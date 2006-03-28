Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWC1OjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWC1OjJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWC1OjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:39:09 -0500
Received: from mail.tmr.com ([64.65.253.246]:9377 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S932284AbWC1OjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:39:07 -0500
Message-ID: <44294B33.3040507@tmr.com>
Date: Tue, 28 Mar 2006 09:41:55 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@sw.ru>
CC: Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, herbert@13thfloor.at, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru>  <44242D4D.40702@yahoo.com.au> <1143228339.19152.91.camel@localhost.localdomain> <4428BB5C.3060803@tmr.com> <4428FB2B.8070805@sw.ru>
In-Reply-To: <4428FB2B.8070805@sw.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Korotaev wrote:

>> Frankly I don't see running 100 VMs as a realistic goal, being able 
>> to run Linux, Windows, Solaris and BEOS unmodified in 4-5 VMs would 
>> be far more useful.
>
> It is more than realistic. Hosting companies run more than 100 VPSs in 
> reality. There are also other usefull scenarios. For example, I know 
> the universities which run VPS for every faculty web site, for every 
> department, mail server and so on. Why do you think they want to run 
> only 5VMs on one machine? Much more! 

I made no commont on what "they" might want, I want to make the rack of 
underutilized Windows, BSD and Solaris servers go away. An approach 
which doesn't support unmodified guest installs doesn't solve any of my 
current problems. I didn't say it was in any way not useful, just not of 
interest to me. What needs I have for Linux environments are answered by 
jails and/or UML.

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

