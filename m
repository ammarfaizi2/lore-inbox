Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268177AbUJCWdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268177AbUJCWdV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 18:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268179AbUJCWdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 18:33:21 -0400
Received: from pop.gmx.de ([213.165.64.20]:26244 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268177AbUJCWdT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 18:33:19 -0400
X-Authenticated: #20450766
Date: Sun, 3 Oct 2004 23:01:30 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>, george@mvista.com,
       Andrew Morton <akpm@osdl.org>, juhl-lkml@dif.dk, clameter@sgi.com,
       drepper@redhat.com, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       libc-alpha@sources.redhat.com
Subject: [OT] Re: patches inline in mail
In-Reply-To: <1096730402.25131.18.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0410032255360.5054@poirot.grange>
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
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

While we are at it, maybe someone could help me with my "antient" pine 
too. When sending patches inline (Ctrl-R) it looks fine up in the email, 
also when I am reading my own email as it came to the list, e.g.

@@ -8,9 +8,9 @@
  static void __inline__
  dc390_freetag (struct dc390_dcb* pDCB, struct dc390_srb* pSRB)
  {
-	if (pSRB->TagNumber < 255) {

However, everybody (not pine-users) complains, that white spaces got 
corrupted. And if I export the email I see

@@ -8,9 +8,9 @@
   static void __inline__
   dc390_freetag (struct dc390_dcb* pDCB, struct dc390_srb* pSRB)
   {
-	if (pSRB->TagNumber < 255) {

(notice the extra space). What is going on there and is there a solution 
(apart from switching to another mailing or sending as attachments)?

Thanks
Guennadi
---
Guennadi Liakhovetski

