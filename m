Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310258AbSCLBBL>; Mon, 11 Mar 2002 20:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310264AbSCLBBG>; Mon, 11 Mar 2002 20:01:06 -0500
Received: from marcy.nas.nasa.gov ([129.99.113.17]:46846 "EHLO
	marcy.nas.nasa.gov") by vger.kernel.org with ESMTP
	id <S310258AbSCLBAJ>; Mon, 11 Mar 2002 20:00:09 -0500
Message-Id: <200203120100.RAA00468@marcy.nas.nasa.gov>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Upgrading Headers?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Mar 2002 17:00:08 -0800
From: Brian S Queen <bqueen@nas.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a person switches to, or upgrades a kernel, how do they upgrade the
associated header files?  The headers in /usr/include won't match the kernel.
I don't see anything about that in the documentation.

When I want to program with my new kernel I need to use the new headers, so I 
have to use #include <linux/fcntl.h> instead of #include <fcntl.h>.  This 
seems odd.

Brian McQueen
NAS Division
NASA/Ames

