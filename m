Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131725AbRBMP1M>; Tue, 13 Feb 2001 10:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131930AbRBMP1C>; Tue, 13 Feb 2001 10:27:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:52489 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131725AbRBMP0w>; Tue, 13 Feb 2001 10:26:52 -0500
Subject: Re: How to install Alan's patches?
To: puckwork@madz.net (Thomas Foerster)
Date: Tue, 13 Feb 2001 15:27:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010213150328Z131694-514+4497@vger.kernel.org> from "Thomas Foerster" at Feb 13, 2001 04:03:02 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ShMU-000241-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> |+++ linux.ac/CREDITS   Fri Feb  9 13:19:13 2001
> --------------------------
> File to patch: 
> [root@space src]#
> 
> Do i have to create linux.vanilla and linux.ac, or what's the magic?! :-)

Calling it linux.ac is one answer. Another one is

cd linux
patch -p1 <../patchfile
