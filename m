Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964999AbWIDWLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWIDWLM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWIDWLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:11:12 -0400
Received: from freehackers.org ([82.225.154.2]:21140 "EHLO freehackers.org")
	by vger.kernel.org with ESMTP id S964999AbWIDWLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:11:10 -0400
From: Thomas Capricelli <orzel@freehackers.org>
Organization: freehackers.org
To: linux-kernel@vger.kernel.org
Subject: zeta-0.5 released : port of linux to the virtual Zeta architecutre
Date: Tue, 5 Sep 2006 00:15:06 +0200
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609050015.06883.orzel@freehackers.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

	Some people might be aware of Zeta linux, an academic project of creating a 
virtual architecture, and porting binutils+gcc+linux to it. There have been 
already  three releases this year (0.3, 0.4 and today, 0.5).

	Quick outplot :
	* Graphical interface for the emulator, with a (simple) page tables browser.
	* the kernel almost boots up to the start of a userspace process.
	* use binutils-2.17, gcc-4.1.1 and linux-2.6.17.

	Everything you want to know about it is on http://orzel.freehackers.org/zeta

	This is of interest mostly to people who, like me, want to know more about 
the toolchain internals and linux core stuff internals (== not drivers, 
subsystems or filesystems).

	The next release will focus on writing the handbook (documentation, howto's, 
specifications..).

best regards,
Thomas
-- 
Thomas Capricelli <orzel@freehackers.org>
http://orzel.freehackers.org/
