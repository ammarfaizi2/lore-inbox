Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268224AbUJCXLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268224AbUJCXLj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268225AbUJCXLj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:11:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:60563 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S268224AbUJCXLh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:11:37 -0400
Date: Mon, 4 Oct 2004 01:18:51 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
       george@mvista.com, Andrew Morton <akpm@osdl.org>, clameter@sgi.com,
       drepper@redhat.com, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: Re: [OT] Re: patches inline in mail
In-Reply-To: <Pine.LNX.4.60.0410032255360.5054@poirot.grange>
Message-ID: <Pine.LNX.4.61.0410040113250.2954@dragon.hygekrogen.localhost>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
  <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com> 
 <4154F349.1090408@redhat.com>  <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
  <41550B77.1070604@redhat.com>  <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
  <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com> 
 <4159B920.3040802@redhat.com>  <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
  <415AF4C3.1040808@mvista.com>  <Pine.LNX.4.58.0409291054230.25276@schroedinger.engr.sgi.com>
  <415B0C9E.5060000@mvista.com>  <Pine.LNX.4.61.0409292143050.2744@dragon.hygekrogen.localhost>
  <415B4FEE.2000209@mvista.com> <20040930222928.1d38389f.akpm@osdl.org> 
 <1096633681.21867.14.camel@localhost.localdomain>  <415DD31A.3020004@mvista.com>
  <87vfdtglrx.fsf@goat.bogus.local> <1096730402.25131.18.camel@localhost.localdomain>
 <Pine.LNX.4.60.0410032255360.5054@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Oct 2004, Guennadi Liakhovetski wrote:

> Hello
> 
> While we are at it, maybe someone could help me with my "antient" pine too.
> When sending patches inline (Ctrl-R) it looks fine up in the email, also when
> I am reading my own email as it came to the list, e.g.
> 
[...]
> 
> (notice the extra space). What is going on there and is there a solution
> (apart from switching to another mailing or sending as attachments)?
> 

Recent Pine versions support a feature called flowed text that can 
whitespace damage your inline patches, you want to turn that off. Could 
probably also be some other setting that's causing it, but I haven't 
delved into it any deeper since my pine config seems to work well (at 
least I'm not getting any complains about damage when I use Ctrl+R to 
insert patches).
If you want it I can send you my .pinerc off-list, just ask for it in 
private email.

--
Jesper Juhl


