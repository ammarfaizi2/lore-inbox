Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315222AbSHOGef>; Thu, 15 Aug 2002 02:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSHOGee>; Thu, 15 Aug 2002 02:34:34 -0400
Received: from mtiwmhc22.worldnet.att.net ([204.127.131.47]:15089 "EHLO
	mtiwmhc22.worldnet.att.net") by vger.kernel.org with ESMTP
	id <S313773AbSHOGed>; Thu, 15 Aug 2002 02:34:33 -0400
Date: Thu, 15 Aug 2002 02:38:32 -0400
From: Kevin Burtch <kburtch@worldnet.att.net>
To: "Eric S. Raymond" <esr@thyrsus.com>, Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: PATCH - Configure.help grammar/readability patch
Message-Id: <20020815023832.62ce8e4d.kburtch@worldnet.att.net>
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Note: I am not currently on the mailing list.

I've been thinking about doing this since the beginning of the
configuration help texts. The majority of the changes are the
replacement of "say" with "select" (along with appropriate
rewording), since even though there are many different ways to
configure the kernel, speech recognition isn't one of them yet. :) 
I've tried to correct the grammar with all of the replacements
as thoroughly as I could, and make it more consistent.
Since I was at it, I also wrapped some of the long lines.

The patch is against 2.4.19, and is located at
  http://www.geocities.com/kevin_burtch/config.patch.gz
(I didn't want to post it since it's over 1MB in size uncompressed)


Thank you very much,
Kevin Burtch

