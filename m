Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314214AbSDVPIF>; Mon, 22 Apr 2002 11:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314215AbSDVPIE>; Mon, 22 Apr 2002 11:08:04 -0400
Received: from www.microgate.com ([216.30.46.105]:57613 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S314214AbSDVPIE>; Mon, 22 Apr 2002 11:08:04 -0400
Subject: [PATCH] 2.4.19-pre7 New Driver synclink_cs.c
From: Paul Fulghum <paulkf@microgate.com>
To: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 22 Apr 2002 10:05:51 -0500
Message-Id: <1019487952.3374.10.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch that adds a new driver for the SyncLink PC Card
(PCMCIA) multiprotocol serial adapter is located at

ftp://ftp.microgate.com/linux/patch-synclink_cs-2.4.19-pre7.gz

This patch is against 2.4.19-pre7

This includes changes requested by Alan for removing
unnecessary global variables and correcting inconsistant
indentation.

Please apply.






