Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314351AbSDVRwH>; Mon, 22 Apr 2002 13:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314348AbSDVRwB>; Mon, 22 Apr 2002 13:52:01 -0400
Received: from www.microgate.com ([216.30.46.105]:26127 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S314347AbSDVRvl>; Mon, 22 Apr 2002 13:51:41 -0400
Subject: [PATCH] 2.5.8 New Driver synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: "torvalds@transmeta.com" <torvalds@transmeta.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 22 Apr 2002 12:49:34 -0500
Message-Id: <1019497774.821.5.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A patch that adds a new driver for the SyncLink Multiport
multiprotocol serial adapter is located at

ftp://ftp.microgate.com/linux/patch-synclinkmp.gz

This patch is against 2.5.8

This includes changes requested by Alan to remove
unnecessary global variables.

Please apply.



