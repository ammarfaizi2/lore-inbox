Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317286AbSIIND7>; Mon, 9 Sep 2002 09:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSIIND7>; Mon, 9 Sep 2002 09:03:59 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:30856 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317286AbSIIND6>; Mon, 9 Sep 2002 09:03:58 -0400
Date: Mon, 9 Sep 2002 15:08:31 +0200 (CEST)
From: Oktay Akbal <oktay.akbal@s-tec.de>
X-X-Sender: oktay@omega.s-tec.de
To: linux-kernel@vger.kernel.org
Subject: md multipath with disk missing ?
Message-ID: <Pine.LNX.4.44.0209091504270.12771-100000@omega.s-tec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.15.0.1; VDF: 6.15.0.6
	 at email has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !

Can someone tell me, how md multipathing works, when a drive fails
completly ?
Does this only work with raid-autodetection ?
When no autodetection is done and a drive is missing, would a raidstart
kill the raid, since the drives are now available with other devices (sda
instead of former sdb...) ?


Oktay Akbal

