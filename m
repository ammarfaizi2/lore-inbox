Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262790AbSJEWWQ>; Sat, 5 Oct 2002 18:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSJEWUu>; Sat, 5 Oct 2002 18:20:50 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:39663 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262760AbSJEWUp>; Sat, 5 Oct 2002 18:20:45 -0400
Subject: [BK 4/6] 2.5.x Bluetooth subsystem update. BNEP support.
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1033856386.6657.93.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 05 Oct 2002 15:25:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #4:

Adds support for BNEP (Bluetooth Network Encapsulation Protocol).
It's basically simple Ethernet emulation on top of Bluetooth.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.699   -> 1.700  
#	net/bluetooth/Makefile	1.4     -> 1.5    
#	net/bluetooth/Config.help	1.2     -> 1.3    
#	net/bluetooth/Config.in	1.2     -> 1.3    
#	               (new)	        -> 1.1     net/bluetooth/bnep/crc32.h
#	               (new)	        -> 1.1     net/bluetooth/bnep/Config.in
#	               (new)	        -> 1.1     net/bluetooth/bnep/crc32.c
#	               (new)	        -> 1.1     net/bluetooth/bnep/bnep.h
#	               (new)	        -> 1.1     net/bluetooth/bnep/core.c
#	               (new)	        -> 1.1     net/bluetooth/bnep/netdev.c
#	               (new)	        -> 1.1     net/bluetooth/bnep/Makefile
#	               (new)	        -> 1.1     net/bluetooth/bnep/sock.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	maxk@viper.(none)	1.700
# BNEP (Bluetooth Network Encapsulation Protocol) support.
# --------------------------------------------

http://bluez.sourceforge.net/patches/bt-2.5-bnep.gz

Max

