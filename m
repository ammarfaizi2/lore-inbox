Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932246AbWGDNT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246AbWGDNT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGDNT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:19:59 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:38266 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932210AbWGDNT6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:19:58 -0400
Message-ID: <44AA6AF8.4010205@fr.ibm.com>
Date: Tue, 04 Jul 2006 15:19:52 +0200
From: Daniel Lezcano <dlezcano@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Vilain <sam@vilain.net>
CC: Andrey Savochkin <saw@swsoft.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, hadi@cyberus.ca,
       Herbert Poetzl <herbert@13thfloor.at>, Alexey Kuznetsov <alexey@sw.ru>,
       viro@ftp.linux.org.uk, devel@openvz.org, dev@sw.ru,
       Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ben Greear <greearb@candelatech.com>,
       Dave Hansen <haveblue@us.ibm.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Russel Coker <russell@coker.com.au>
Subject: Re: strict isolation of net interfaces
References: <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com> <44A49121.4050004@vilain.net> <20060703185350.A16826@castle.nmd.msu.ru> <44AA5F28.9040109@fr.ibm.com> <44AA6994.5010202@vilain.net>
In-Reply-To: <44AA6994.5010202@vilain.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain wrote:
> Daniel Lezcano wrote:
> 
>>If it is ok for you, we can collaborate to merge the two solutions in
>>one. I will focus on layer 3 isolation and you on the layer 2.
> 
> 
> So, you're writing a LSM module or adapting the BSD Jail LSM, right? :)
> 
> Sam.

No. I am adapting a prototype of network application container we did.

   -- Daniel
