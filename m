Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287965AbSAMDFs>; Sat, 12 Jan 2002 22:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSAMDF2>; Sat, 12 Jan 2002 22:05:28 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:54788 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287965AbSAMDFX>; Sat, 12 Jan 2002 22:05:23 -0500
Subject: Re: [CFT][PATCH] ide-floppy cleanups/media change detection (5/5)
To: kevin@labsysgrp.com (Kevin P. Fleming)
Date: Sun, 13 Jan 2002 03:17:04 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, paul@paulbristow.net (Paul Bristow)
In-Reply-To: <006f01c19bdd$a4d5fe90$6caaa8c0@kevin> from "Kevin P. Fleming" at Jan 12, 2002 07:54:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16Pb8q-0003ub-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Patch 5 follows, implementing media change detection as follows:

Please don't post patches with ms lookout. You lose the tab/spaces and they
get wrapped and mangled into oblivion.

Secondly - you probably want to pick up Andre Hedrick's linux-ide stuff that
is waiting to go in (www.linux-ide.org) and merge against that then submit
it to Andre. That may also help you in other ways as the new core code is
somewhat cleaner
