Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262260AbRERGzD>; Fri, 18 May 2001 02:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262262AbRERGyx>; Fri, 18 May 2001 02:54:53 -0400
Received: from www.sinfopragma.it ([213.26.181.2]:10251 "EHLO
	sinfo-www-01.sinfopragma.it") by vger.kernel.org with ESMTP
	id <S262260AbRERGyp>; Fri, 18 May 2001 02:54:45 -0400
Date: Fri, 18 May 2001 08:59:22 +0200 (W. Europe Daylight Time)
From: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>
To: <linux-kernel@vger.kernel.org>
Subject: New AIC7xxx driver - Berkeley DB1 to DB3
Message-ID: <Pine.WNT.4.31.0105180857350.65-100000@pc209.sinfopragma.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can someone verify if it's legal to change the include/link in the
assembler for AIC7xxx ? DB 1.85 has header clash with DB 3 (db.h).

It SEEMS to work but I'd rather be sure (since I've got that nasty 32
bit corruption prob on SCSI char devices...)

				-- Lorenzo Marcantonio


