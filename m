Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSIAD0E>; Sat, 31 Aug 2002 23:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSIAD0E>; Sat, 31 Aug 2002 23:26:04 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3712 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S313898AbSIAD0D>;
	Sat, 31 Aug 2002 23:26:03 -0400
Date: Sat, 31 Aug 2002 22:23:43 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: 2.5.33-bk testing
Message-ID: <Pine.LNX.4.44.0208312209240.1129-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch had been previously sent to the list fixing the __FUNCTION__ 
problem in ip_nat_helper.c was missing.  It was needed before the file 
would compile.

I've beat on the floppy driver and it seems to work well.  I haven't been 
able to make it hiccup yet.

The IDE subsystem likewise seems stable in limited testing.  

