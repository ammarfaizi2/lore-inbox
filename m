Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266674AbUJAWGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266674AbUJAWGU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 18:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUJAWBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 18:01:32 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:58872 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S266786AbUJAV72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 17:59:28 -0400
Message-ID: <415DD31A.3020004@mvista.com>
Date: Fri, 01 Oct 2004 14:58:50 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Andrew Morton <akpm@osdl.org>, juhl-lkml@dif.dk, clameter@sgi.com,
       drepper@redhat.com, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: patches inline in mail
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>	 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>	 <4154F349.1090408@redhat.com>	 <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>	 <41550B77.1070604@redhat.com>	 <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>	 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>	 <4159B920.3040802@redhat.com>	 <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>	 <415AF4C3.1040808@mvista.com>	 <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>	 <415B0C9E.5060000@mvista.com>	 <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>	 <415B4FEE.2000209@mvista.com>  <20040930222928.1d38389f.akpm@osdl.org> <1096633681.21867.14.camel@localhost.localdomain>
In-Reply-To: <1096633681.21867.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Gwe, 2004-10-01 at 06:29, Andrew Morton wrote:
> 
>>> Guild lines on how to insure this are welcome.
>>
>>Send angry email to everyone@mozilla.org.  AFAICT it's impossible with
>>recent mailnews.
> 
> 
> The mozilla behaviour is RFC compliant[1]. Use text/plain attachments
> and mark them "to view" and it should do happier things. (Except with
> Linus cos Mr Dinosaur[2] doesn't believe in MIME yet)

Just how does one "mark them "to view" "?

George
> 
> I've not been able to coax Evolution into not chewing on non attached
> text either (again RFC compliant but not useful). If anyone knows a
> magic incantation for it I'd love to know.
> 
> (and it might be a good addition to the lkml faq)
> 
> Alan
> [1] Yes the RFC is stupid but its the spec nowdays
> [2] Thankfully not purple and singing
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

