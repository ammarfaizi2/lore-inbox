Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261522AbSJMOCW>; Sun, 13 Oct 2002 10:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261525AbSJMOCW>; Sun, 13 Oct 2002 10:02:22 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:58790 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261522AbSJMOCV> convert rfc822-to-8bit; Sun, 13 Oct 2002 10:02:21 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: O(1) with Preempt issue
Date: Sun, 13 Oct 2002 16:07:35 +0200
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210131607.35012.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I have an issue with O(1) and preempt, and I am not able to find out why I get 
"exited with preempt_count 1" with every program I run.

If anyone care to have a look at my sched.c, find it here:

http://wolk.sf.net/sched.c

many thnx!

ciao, Marc
