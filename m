Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262510AbSI3Q2Y>; Mon, 30 Sep 2002 12:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262541AbSI3Q2X>; Mon, 30 Sep 2002 12:28:23 -0400
Received: from 62-190-216-107.pdu.pipex.net ([62.190.216.107]:56836 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262510AbSI3Q1s>; Mon, 30 Sep 2002 12:27:48 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209301640.g8UGe0ef006799@darkstar.example.net>
Subject: Re: v2.6 vs v3.0
To: torvalds@transmeta.com (Linus Torvalds)
Date: Mon, 30 Sep 2002 17:39:59 +0100 (BST)
Cc: jdickens@ameritech.net, mingo@elte.hu, jgarzik@pobox.com,
       kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, saw@saw.sw.com.sg, rusty@rustcorp.com.au,
       richardj_moore@uk.ibm.com
In-Reply-To: <Pine.LNX.4.44.0209291040420.2240-100000@home.transmeta.com> from "Linus Torvalds" at Sep 29, 2002 10:42:04 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How many people are sitting on the sidelines waiting for guarantee that ide is 
> > not going to blow up on our filesystems and take our data with it. Guarantee 
> > that ide is working and not dangerous to our data, then I bet a lot more 
> > people will come back and bang on 2.5. 
> 
> How the hell can I _guarantee_ anything like that?

You don't need to - just post "2.5.x ide is working, and not dangerous to your data", and loads of people will start using it.  That way, we get it tested a decent amount.

Of course when somebody's root fs get fsck'ed, (pun intended), the list is bound to get a flamewar^Whelpfully worded bug report.

The false rumors that IDE was fubar for a long time in 2.5.x, coupled with the fact that a lot of recent 2.5.x kernels don't compile, seem to have scared off people which is rediculous.

John.
