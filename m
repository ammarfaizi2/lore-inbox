Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbTDYUoa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTDYUoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:44:30 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263972AbTDYUo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:44:27 -0400
Date: Fri, 25 Apr 2003 13:56:38 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.68-osdl2
Message-Id: <20030425135638.01776b16.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: "X*Tf$\39*#12x9f4a&W79R_G<Lp.-M~+qwIR"@uUIc5)mtN`8t5PlMZ4-h6A-\ng98+D(8
 %&$>hQ^0;EZ/Gffni}&Hw2Af=i=rm\j?5D>Tn23Sw*w1x")kgRA7{BlH?R]"jIF_fOaRpEq^@k21WU
 u)*dUq
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://prdownloads.sourceforge.net/osdldcl/patch-2.5.68-osdl2.bz2?download

or OSDL Patch Lifecycle Manager (http://www.osdl.org/cgi-bin/plm/)
	osdl-2.5.68-2	PLM # 1800

New:
o Lockmeter

Dropped:
o Cpu Hot Plug
  Not stable enough yet.
o Improved boot time TSC synchronization
  No demand and not integrated into mainline
o Megaraid 2 driver
  Newer version in process of getting into mainline

Retained from: 2.5.68-osdl1

o Atomic 64 bit i_size access		(Daniel McNeil)
o Pentium Performance Counters		(Mikael Pettersson)
o Linux Trace Toolkit (LTT)             (Karim Yaghmour)
o Kernel Config (ikconfig)		(Randy Dunlap)
o RCU statistics               		(Dipankar Sarma)
o Scheduler tunables            	(Robert Love)
