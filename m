Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267452AbSLLKDs>; Thu, 12 Dec 2002 05:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbSLLKDs>; Thu, 12 Dec 2002 05:03:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:29170 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267452AbSLLKDr>;
	Thu, 12 Dec 2002 05:03:47 -0500
Message-ID: <3DF860BF.CF41042E@digeo.com>
Date: Thu, 12 Dec 2002 02:11:11 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>,
       "linux-audio-dev@music.columbia.edu" 
	<linux-audio-dev@music.columbia.edu>
Subject: 2.4.20 low-latency patch
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Dec 2002 10:11:27.0270 (UTC) FILETIME=[D5396460:01C2A1C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


At http://www.zip.com.au/~akpm/linux/2.4.20-low-latency.patch.gz

Very much in sustaining mode.  It includes a fix for a livelock
problem in fsync() from Stephen Tweedie.
