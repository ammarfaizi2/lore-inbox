Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSIERbf>; Thu, 5 Sep 2002 13:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317434AbSIERbf>; Thu, 5 Sep 2002 13:31:35 -0400
Received: from ns.tiani.com ([62.116.38.110]:42493 "EHLO mail.tiani.com")
	by vger.kernel.org with ESMTP id <S317359AbSIERbe>;
	Thu, 5 Sep 2002 13:31:34 -0400
Date: Thu, 5 Sep 2002 19:37:09 +0200 (CEST)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
X-X-Sender: kianusch@merlin
To: linux-kernel@vger.kernel.org
Subject: tuning/turning off disc caching?
Message-ID: <Pine.LNX.4.43.0209051929160.2388-100000@merlin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Is there a way tuning (down) or turning off the disc caching in Linux for
certain devices?

What I do is writing data via dd or mkisofs directly to a DVD-RAM
(/dev/srX).  The kernel sees the DVD-RAM as a hard-disc.  It works fine.
The Problem is that during the write operation (which takes some time for
4,7GB data).  The system slows down extremely and all the memory is used
for caching.

Please include me as CC, since I'm not on the list.

Regards
   K. Sayah Karadji

