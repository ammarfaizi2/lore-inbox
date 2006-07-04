Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWGDNOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWGDNOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 09:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWGDNOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 09:14:15 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:32185 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932209AbWGDNOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 09:14:14 -0400
Message-ID: <44AA6994.5010202@vilain.net>
Date: Wed, 05 Jul 2006 01:13:56 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: Andrey Savochkin <saw@swsoft.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
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
References: <20060627225213.GB2612@MAIL.13thfloor.at> <1151449973.24103.51.camel@localhost.localdomain> <20060627234210.GA1598@ms2.inr.ac.ru> <m1mzbyj6ft.fsf@ebiederm.dsl.xmission.com> <20060628133640.GB5088@MAIL.13thfloor.at> <1151502803.5203.101.camel@jzny2> <44A44124.5010602@vilain.net> <44A450D1.2030405@fr.ibm.com> <20060630023947.GA24726@sergelap.austin.ibm.com> <44A49121.4050004@vilain.net> <20060703185350.A16826@castle.nmd.msu.ru> <44AA5F28.9040109@fr.ibm.com>
In-Reply-To: <44AA5F28.9040109@fr.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano wrote:
> 
> If it is ok for you, we can collaborate to merge the two solutions in
> one. I will focus on layer 3 isolation and you on the layer 2.

So, you're writing a LSM module or adapting the BSD Jail LSM, right? :)

Sam.
