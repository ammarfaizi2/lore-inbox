Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSJEWWe>; Sat, 5 Oct 2002 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbSJEWWW>; Sat, 5 Oct 2002 18:22:22 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:40943 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262783AbSJEWUt>; Sat, 5 Oct 2002 18:20:49 -0400
Subject: [BK 5/6] 2.5.x Bluetooth subsystem update. RFCOMM support.
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1033856548.6657.97.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 05 Oct 2002 15:25:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #5:

Adds support for RFCOMM layer. RFCOMM is the connection oriented stream
transport. Provides socket and TTY interfaces.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.700   -> 1.701  
#	net/bluetooth/Makefile	1.5     -> 1.6    
#	net/bluetooth/Config.help	1.3     -> 1.4    
#	net/bluetooth/Config.in	1.3     -> 1.4    
#	               (new)	        -> 1.1     net/bluetooth/rfcomm/core.c
#	               (new)	        -> 1.1     include/net/bluetooth/rfcomm.h
#	               (new)	        -> 1.1     net/bluetooth/rfcomm/crc.c
#	               (new)	        -> 1.1     net/bluetooth/rfcomm/Config.in
#	               (new)	        -> 1.1     net/bluetooth/rfcomm/tty.c
#	               (new)	        -> 1.1     net/bluetooth/rfcomm/sock.c
#	               (new)	        -> 1.1     net/bluetooth/rfcomm/Makefile
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	maxk@viper.(none)	1.701
# RFCOMM protocol support.
# RFCOMM socket and TTY emulation APIs.
# --------------------------------------------

http://bluez.sourceforge.net/patches/bt-2.5-rfcomm.gz

Max

