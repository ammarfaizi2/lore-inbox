Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261594AbTABOZR>; Thu, 2 Jan 2003 09:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTABOZQ>; Thu, 2 Jan 2003 09:25:16 -0500
Received: from tomts20.bellnexxia.net ([209.226.175.74]:3969 "EHLO
	tomts20-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S261594AbTABOZP>; Thu, 2 Jan 2003 09:25:15 -0500
Date: Thu, 2 Jan 2003 09:32:47 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: kernel .config support?
Message-ID: <Pine.LNX.4.44.0301020930510.7804-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  whatever happened to that funky option from 2.4 --
for kernel .config support, which allegedly buried the
config file inside the kernel itself.  (it never worked --
the alleged extraction script scripts/extract-ikconfig
depended on a program called "binoffset" that didn't 
exist in that distribution.)

  any plans to resurrect this, or something like it?

rday

