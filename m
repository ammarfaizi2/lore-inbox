Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273065AbRKHPAI>; Thu, 8 Nov 2001 10:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273622AbRKHO76>; Thu, 8 Nov 2001 09:59:58 -0500
Received: from mustard.heime.net ([194.234.65.222]:34262 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S273588AbRKHO7t>; Thu, 8 Nov 2001 09:59:49 -0500
Date: Thu, 8 Nov 2001 15:59:47 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: Large files and filesystem block size
Message-ID: <Pine.LNX.4.30.0111081553470.1479-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I'm setting up a server serving large >=1GB files. I spoke to this guy
that just finished his PhD on the subject
(http://ConfMan.unik.no/~paalh/index2.html) , and he said he'd managed to
increase the throughput by using a 64kB block size on the files system.
This testing was done on NetBSD (as far as I can remember).

Does anyone know of a file system that supports large files, large
filesystems and large block sizes?

Does any of you have any theories if his practice in using larger block
sizes will have the same impact on performance in Linux as it had in BSD?

Thank you

roy
--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

