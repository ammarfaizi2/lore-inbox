Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTAIQnL>; Thu, 9 Jan 2003 11:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266886AbTAIQnL>; Thu, 9 Jan 2003 11:43:11 -0500
Received: from as12-5-6.spa.s.bonet.se ([217.215.177.162]:13024 "EHLO
	www.tnonline.net") by vger.kernel.org with ESMTP id <S266859AbTAIQnK>;
	Thu, 9 Jan 2003 11:43:10 -0500
Date: Thu, 9 Jan 2003 17:50:34 +0100
From: Anders Widman <andewid@tnonline.net>
X-Mailer: The Bat! (v1.63 Beta/2)
Reply-To: Anders Widman <andewid@tnonline.net>
Organization: TNOnline.net
X-Priority: 3 (Normal)
Message-ID: <8831168500.20030109175034@tnonline.net>
To: =?ISO-8859-1?B?RGlldGVyIE78dHplbA==?= <Dieter.Nuetzel@hamburg.de>
CC: Brian Tinsley <btinsley@emageon.com>, Russell Coker <russell@coker.com.au>,
       ReiserFS <reiserfs-list@namesys.com>, Rik van Riel <riel@nl.linux.org>,
       Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: kswapd CPU usage and heavy disk IO
In-Reply-To: <200301091742.51101.Dieter.Nuetzel@hamburg.de>
References: <200301091431.54451.russell@coker.com.au>
 <3E1D9D10.40700@emageon.com> <200301091742.51101.Dieter.Nuetzel@hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Are you sure it is a ReiserFS and not a kernel thing?

I  would  think it is probably not. I have seen this also when running
things  like  "badblocks  /dev/hdb"  and  the  kswapd  eats up all CPU
recourses.  Then  again I am always using ReiserFS so I do not know if
the  ReiserFS  is the cause or not.. But judging from badblocks is not
FS dependantI think there is no wrong with ReiserFS =)

//Anders

