Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130542AbRCIRI7>; Fri, 9 Mar 2001 12:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130543AbRCIRIt>; Fri, 9 Mar 2001 12:08:49 -0500
Received: from [208.204.44.103] ([208.204.44.103]:30991 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S130542AbRCIRIh>; Fri, 9 Mar 2001 12:08:37 -0500
Date: Fri, 9 Mar 2001 10:16:23 -0600 (CST)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic 2.2.19pre11
Message-ID: <Pine.LNX.4.10.10103091010590.18247-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tyan Thunderbird 2510 MBd with server works le bios and dual eepro100
82559 nics running 2.2.19pre11 and either Donald's driver 1.13 or intel's
driver 1.5.5a we get the following kernel panic after about 6 hrs of run:

Kernel panic:
shput: under: 
80194fa2:1480
put:584

This is not running with the nics bonded.

Jay

