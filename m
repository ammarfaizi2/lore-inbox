Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVKOQp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVKOQp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 11:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964916AbVKOQp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 11:45:29 -0500
Received: from winmain.rutgers.edu ([128.6.230.194]:45744 "EHLO
	liman.rutgers.edu") by vger.kernel.org with ESMTP id S964830AbVKOQp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 11:45:28 -0500
Reply-To: <satyavol@winmain.rutgers.edu>
From: "Surya Satyavolu" <satyavol@winmain.rutgers.edu>
To: "'Christoph Lameter'" <clameter@engr.sgi.com>,
       "'Andrew Morton'" <akpm@osdl.org>
Cc: <torvalds@osdl.org>, <marcelo.tosatti@cyclades.com>, <kravetz@us.ibm.com>,
       <raybry@mpdtxmail.amd.com>, <lee.schermerhorn@hp.com>,
       <linux-kernel@vger.kernel.org>, <magnus.damm@gmail.com>, <pj@sgi.com>,
       <haveblue@us.ibm.com>, <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: SKB tutorial, Blog, and NET TODO
Date: Tue, 15 Nov 2005 11:43:22 -0500
Organization: WINLAB
Message-ID: <000501c5ea03$b54003c0$b77aa8c0@mobile38>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.62.0511150837190.9258@schroedinger.engr.sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Patrick,
           I found your email on netdev mailing list. I see that a
priority argument has been added to hard_start_xmit() in the latest
IPW2200. Is there a user space API to use the new argument with the
existing socket API? Does one need to necessarily add a new
sys_socketcall to utilize the priority argument in hard_start_xmit().
Any info shared on this would be very much appreciated. Thanks! Surya

