Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293076AbSDXItF>; Wed, 24 Apr 2002 04:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293092AbSDXItE>; Wed, 24 Apr 2002 04:49:04 -0400
Received: from qui-gon.bcc.bilkent.edu.tr ([139.179.14.51]:50560 "HELO
	qui-gon.bcc.bilkent.edu.tr") by vger.kernel.org with SMTP
	id <S293076AbSDXItD>; Wed, 24 Apr 2002 04:49:03 -0400
Date: Wed, 24 Apr 2002 11:46:33 +0300 (EEST)
From: Yavuz Selim Komur <komur@qui-gon.bcc.bilkent.edu.tr>
To: linux-kernel@vger.kernel.org
Subject: net/core/dev.c:1465
Message-ID: <Pine.LNX.4.44.0204241144460.19026-100000@qui-gon.bcc.bilkent.edu.tr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


if enable DIVERT option

handle_diverter() is void, ret is a int value..

-- 
Yavuz

