Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262545AbTDAOLC>; Tue, 1 Apr 2003 09:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262546AbTDAOLC>; Tue, 1 Apr 2003 09:11:02 -0500
Received: from krynn.axis.se ([193.13.178.10]:32897 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S262545AbTDAOLC>;
	Tue, 1 Apr 2003 09:11:02 -0500
Message-ID: <3C6BEE8B5E1BAC42905A93F13004E8AB017DE982@mailse01.se.axis.com>
From: Mikael Starvik <mikael.starvik@axis.com>
To: "'tomlins@cam.org'" <tomlins@cam.org>, "'CaT'" <cat@zip.com.au>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Date: Tue, 1 Apr 2003 16:22:18 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>What does tmpfs have to do with ram size?  Its swappable.  This _might_ be
>useful for ramfs but for tmpfs, IMHO, its not a good idea.

All systems that uses tmpfs doesn't necessairly have a swap, 
tmpfs is used in several diskless embedded systems.

/Mikael
