Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314352AbSDVRxX>; Mon, 22 Apr 2002 13:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314348AbSDVRwJ>; Mon, 22 Apr 2002 13:52:09 -0400
Received: from www.microgate.com ([216.30.46.105]:25359 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S314338AbSDVRuX>; Mon, 22 Apr 2002 13:50:23 -0400
Subject: [PATCH] 2.4.19-pre7 New Driver synclinkmp.c
From: Paul Fulghum <paulkf@microgate.com>
To: "marcelo@conectiva.com.br" <marcelo@conectiva.com.br>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 22 Apr 2002 12:48:14 -0500
Message-Id: <1019497694.821.2.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch that adds a new driver for the SyncLink Multiport
multiprotocol serial adapter is located at

ftp://ftp.microgate.com/linux/patch-synclinkmp-2.4.19-pre7.gz

This patch is against 2.4.19-pre7

This includes changes requested by Alan to remove
unnecessary global variables.

Please apply.




