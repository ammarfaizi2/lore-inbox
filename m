Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264439AbTDOLYW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264440AbTDOLYW 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:24:22 -0400
Received: from cuculus.hub.gts.cz ([195.39.57.22]:30218 "EHLO
	cuculus.switch.gts.cz") by vger.kernel.org with ESMTP
	id S264439AbTDOLYV (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 07:24:21 -0400
Date: Tue, 15 Apr 2003 13:36:09 +0200
From: Petr Cisar <pc@cuculus.switch.gts.cz>
To: linux-kernel@vger.kernel.org
Subject: Kernels since 2.5.60 upto 2.5.67 freeze when X server terminates
Message-ID: <20030415133608.A1447@cuculus.switch.gts.cz>
Reply-To: Petr Cisar <petr.cisar@gtsgroup.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Since 2.5.60, I have been experiencing problems with a complete system freeze or random oopses when the X-server terminates. It is happening on both machines I am using whose hardware configuration differs slightly, however both of them are equipped with ATI video cards (ATI Rage 128 and ATI Radeon 8500), and both of them run the same version of X-server. That's about all they have in common.

The version of X-server I am using is:
XFree86 Version 4.3.0
Release Date: 27 February 2003

Since the crash either results in an oops obviously not having to do with the core problem, or the system freezes dead (no ping, no reaction to SysRq key), I don't know how to get some debug information to describe the fault more precisely.

Has anyone notyiced similar problems and is there some documentation how to trace such deadly bugs ?

Petr
