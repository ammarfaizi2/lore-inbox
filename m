Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314229AbSDVPOE>; Mon, 22 Apr 2002 11:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314230AbSDVPOD>; Mon, 22 Apr 2002 11:14:03 -0400
Received: from www.microgate.com ([216.30.46.105]:61197 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S314229AbSDVPOB>; Mon, 22 Apr 2002 11:14:01 -0400
Subject: [PATCH] 2.5.8 New Driver synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "torvalds@transmeta.com" <torvalds@transmeta.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 22 Apr 2002 10:11:53 -0500
Message-Id: <1019488314.1678.13.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch that adds a new driver for the SyncLink PC Card
(PCMCIA) multiprotocol serial adapter is located at

ftp://ftp.microgate.com/linux/patch-synclink_cs.gz

This patch is against 2.5.8

This includes changes requested by Alan for removing
unnecessary global variables and correcting inconsistant
indentation.

Please apply.




