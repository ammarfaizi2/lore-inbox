Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273457AbRIVERJ>; Sat, 22 Sep 2001 00:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273504AbRIVEQ7>; Sat, 22 Sep 2001 00:16:59 -0400
Received: from kiln.isn.net ([198.167.161.1]:11533 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id <S273457AbRIVEQw>;
	Sat, 22 Sep 2001 00:16:52 -0400
Message-ID: <3BAC1068.86F8D0F4@isn.net>
Date: Sat, 22 Sep 2001 01:15:36 -0300
From: "Garst R. Reese" <reese@isn.net>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.10-pre13 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: crc calculations
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be huge amounts of code devoted to crc16 and crc32
calculation scattered through the kernel and drivers. Would it not be
possible to have a few generalized routines?
cc Garst
