Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSLOUOY>; Sun, 15 Dec 2002 15:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSLOUOY>; Sun, 15 Dec 2002 15:14:24 -0500
Received: from codeblau.walledcity.de ([212.84.209.34]:17 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id <S262937AbSLOUOX>;
	Sun, 15 Dec 2002 15:14:23 -0500
Date: Sun, 15 Dec 2002 21:22:27 +0100
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: Machine Check Exception
Message-ID: <20021215202227.GA7375@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As soon as I start oggenc on my 2.5 kernel, I get this message:

  CPU 0: Machine Check Exception: 0000000000000004
  Bank 0: f60600000000135 at 000000001ea46db0
  Kernel panic: CPU context corrupt

This vc then hangs, but I could log in and write down the message on
another vc.  Is this a hardware error?  Should I replace my CPU?  My
memory?  Is my machine overheating?  I have had several strange and
unexplained segfaults and reboots under 2.4 recently.

Felix
