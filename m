Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264337AbTH2Gnf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 02:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTH2Gne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 02:43:34 -0400
Received: from lakemtao06.cox.net ([68.1.17.115]:63383 "EHLO
	lakemtao06.cox.net") by vger.kernel.org with ESMTP id S264337AbTH2Gnd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 02:43:33 -0400
From: GibsonSG <gibsonsg@cox.net>
To: mec@shout.net
Subject: Error Report
Date: Fri, 29 Aug 2003 01:41:07 -0500
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308290141.07070.gibsonsg@cox.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menuconfig has encountered a possible error in one of the kernel's 
configuration files and is unable to continue.  Here is the error report:

Q> scripts/Menuconfig: line 832: MCmenu71: command not found

I have received this error when compiling both 2.4.21-0.13mdk and 2.4.22-1mdk 
when attempting to open the ALSA sound menu.
