Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263572AbUDRSWM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 14:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263611AbUDRSWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 14:22:11 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:18445 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S263572AbUDRSWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 14:22:09 -0400
Date: Sun, 18 Apr 2004 20:22:23 +0200
From: Jean Delvare <khali@linux-fr.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: Permissions on include/video/neomagic.h
Message-Id: <20040418202223.6b226e19.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, hi Linus,

In linux-2.6.5.tar, include/video/neomagic.h has permissions 0640. It
obviously should be 0644.

This has already been reported 8 months ago:
http://lkml.org/lkml/2003/8/9/150

Shouldn't it be fixed?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
