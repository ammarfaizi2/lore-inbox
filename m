Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276558AbRJKRQG>; Thu, 11 Oct 2001 13:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRJKRP5>; Thu, 11 Oct 2001 13:15:57 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:60168 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S276558AbRJKRPp>;
	Thu, 11 Oct 2001 13:15:45 -0400
Date: Thu, 11 Oct 2001 10:17:58 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: linux-kernel@vger.kernel.org
Subject: linux-2.4.12 breaks debian install disks
Message-ID: <Pine.LNX.4.10.10110111008300.24112-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When trying to load a reiserfs enabled boot disk on a Dell PowerEdge 
I get:

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem) readonly.
Freeimg unused kernel memory: 192k freed
(hangs here) 

The problem appears on 2.4.11-pre6 and 2.4.12 but 2.4.9 was fine.
This problem appears both whith and without the Dell AACraid patches.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

