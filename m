Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276547AbSIVGGx>; Sun, 22 Sep 2002 02:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276628AbSIVGGx>; Sun, 22 Sep 2002 02:06:53 -0400
Received: from packet.digeo.com ([12.110.80.53]:36326 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S276547AbSIVGGw>;
	Sun, 22 Sep 2002 02:06:52 -0400
Message-ID: <3D8D5F2A.BC057FC4@digeo.com>
Date: Sat, 21 Sep 2002 23:11:54 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: 2.5.38-mm1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2002 06:11:55.0262 (UTC) FILETIME=[F36141E0:01C261FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well that didn't last very long.

url: http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.38/2.5.38-mm1/

+filemap-fixes.patch

 Fix mm/filemap.c for 64-bit builds: replace `unsigned' with size_t.
