Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSJEWWa>; Sat, 5 Oct 2002 18:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262787AbSJEWWZ>; Sat, 5 Oct 2002 18:22:25 -0400
Received: from mail1.qualcomm.com ([129.46.64.223]:40431 "EHLO
	mail1.qualcomm.com") by vger.kernel.org with ESMTP
	id <S262779AbSJEWUr>; Sat, 5 Oct 2002 18:20:47 -0400
Subject: [BK 1/6] 2.5.x Bluetooth subsystem update. Core.
From: "Maksim (Max) " Krasnyanskiy <maxk@qualcomm.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1033856154.6656.87.camel@champ.qualcomm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.5.99 
Date: 05 Oct 2002 15:25:37 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the set of patches to sync up 2.5.x Bluetooth subsytem with
2.4.x and add latest fixes and features.

You can either pull all of them from:
	bk://linux-bt.bkbits.net/bt-2.5

Or apply them indivdually. Patches are pretty big and therefor not
inlined.

Patch #1:
   
# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or
higher.
# This patch includes the following deltas:
#	           ChangeSet	1.597   -> 1.598  
#	net/bluetooth/hci_event.c	1.1     -> 1.2    
#	 net/bluetooth/lib.c	1.3     -> 1.4    
#	net/bluetooth/af_bluetooth.c	1.4     -> 1.5    
#	 net/bluetooth/sco.c	1.2     -> 1.3    
#	net/bluetooth/hci_core.c	1.6     -> 1.7    
#	include/net/bluetooth/bluetooth.h	1.4     -> 1.5    
#	include/net/bluetooth/hci_core.h	1.3     -> 1.4    
#	net/bluetooth/hci_sock.c	1.5     -> 1.6    
#	net/bluetooth/l2cap.c	1.6     -> 1.7    
#	include/net/bluetooth/hci.h	1.3     -> 1.4    
#	net/bluetooth/hci_conn.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/04	root@viper.(none)	1.598
# Sync up Bluetooth core with 2.4.x.
# SMP locking fixes. 
# Support for Hotplug.
# Support for L2CAP connectionless channels (SOCK_DGRAM).
# HCI filter handling fixes.
# Other minor fixes and cleanups.
# --------------------------------------------

http://bluez.sourceforge.net/patches/bt-2.5-core.gz

Max

