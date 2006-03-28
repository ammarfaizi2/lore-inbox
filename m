Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750993AbWC1JAh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbWC1JAh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWC1JAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:00:37 -0500
Received: from mail.sw-soft.com ([69.64.46.34]:58291 "EHLO mail.sw-soft.com")
	by vger.kernel.org with ESMTP id S1750723AbWC1JAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:00:36 -0500
Message-ID: <4428FB2B.8070805@sw.ru>
Date: Tue, 28 Mar 2006 13:00:27 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com>
In-Reply-To: <4428BB5C.3060803@tmr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frankly I don't see running 100 VMs as a realistic goal, being able to 
> run Linux, Windows, Solaris and BEOS unmodified in 4-5 VMs would be far 
> more useful.
It is more than realistic. Hosting companies run more than 100 VPSs in 
reality. There are also other usefull scenarios. For example, I know the 
universities which run VPS for every faculty web site, for every 
department, mail server and so on. Why do you think they want to run 
only 5VMs on one machine? Much more!

Thanks,
Kirill
