Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbTKHRGo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbTKHRGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:06:44 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:18592 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261837AbTKHRGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:06:43 -0500
Reply-To: <ktatgenhorst@comcast.net>
From: "Karl" <ktatgenhorst@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: missing asm-generic during make config
Date: Sat, 8 Nov 2003 11:07:10 -0500
Message-ID: <NDBBJHDEALBBOIDJGBNNCEGFCJAA.ktatgenhorst@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

    I am a list newby and did look for this info, I apologize if my search
was just not good enough. I have installed 2.6.0 test 9 on 2 machines of
mine. One is a gateway Pentium II PC and the other is an IBM Netfinity
server. In both cases when I tried running make config I was given the
message (I apologize I went on and am paraphrasing) asm-generic/errno.h no
such file. In both cases I went in to the /usr/include directory and created
a symlink ln -s /usr/src/linux/include/asm-generic asm-generic and it
worked. My question is did I miss a README file somewhere which would cover
this? I think I did all the steps as per instructions on both machines (they
certainly compiled nicely and run well). I did not include very much about
the configurations of my machines as I thought they would be unnecessary as
this is almost certainly a procedural error on my part and not a bug.

   I appreciate any answers to this and apologize if it is redundant.


Thank you,

Karl Tatgenhorst

