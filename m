Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTBAHDG>; Sat, 1 Feb 2003 02:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTBAHDG>; Sat, 1 Feb 2003 02:03:06 -0500
Received: from ts46-03-qds26.cbn.wa.charter.com ([68.116.27.27]:25984 "EHLO
	furcntrl.khat-fox.com") by vger.kernel.org with ESMTP
	id <S264730AbTBAHDG>; Sat, 1 Feb 2003 02:03:06 -0500
Date: Fri, 31 Jan 2003 23:12:47 -0800 (PST)
From: Chris Bradford <lkml-read@khat-fox.com>
To: linux-kernel@vger.kernel.org
Subject: Current Status of Module Utilities for 2.5 Kernels?
Message-ID: <Pine.LNX.4.52.0301312304210.22442@furcntrl.khat-fox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using Slackware 9.0 beta as my distribution, which uses gcc 3.2.1 as
its C compiler.  My problems started when I noted that kernel 2.4 is not
compilable by gcc v3.x.  I upgraded to linux 2.5.59, which does work with
gcc 3.x.  My upgrade produced another hitch, I was unable to use modules.
My video card, which uses an nVidia TNT2, is of limited usefulness without
the ability to load modules.

Is there a work-around for my problems?
