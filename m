Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266527AbUHOHvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266527AbUHOHvk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266531AbUHOHvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:51:40 -0400
Received: from mypants.xalien.org ([64.81.58.123]:26372 "EHLO
	mypants.xalien.org") by vger.kernel.org with ESMTP id S266527AbUHOHvi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:51:38 -0400
From: Dragan Stancevic <visitor@xalien.org>
To: linux-kernel@vger.kernel.org, visitor@xalien.org
Subject: Terrible Memory leak on 2.6
Date: Sun, 15 Aug 2004 00:51:34 -0700
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408150051.34157.visitor@xalien.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

has anyone else by any chance seen a memory leak during ripping of CDs
or writing CDs. On my system SuSE 9.1 "2.6.5-7.104-default" I can only,
rip or burn one CD. The system runs out of memory and hangs about
half way through the second cd.

I tried just creating the image but not writing and than doesn't seem to
cause the problem. Only when the CD burner is used I see this problem.

The burner is an Emprex DVDRW 1008IM, used on an Athlon XP 2500+
system with 1GB of ram and 1GB of swap. The system seems to lock up
when all the ram is exhausted, the swap is about 90% free.

I haven't debugged the problem much I just wanted to ask around before
I start digging in.

Thanks.

-- 
Peace can only come as a natural consequence
of universal enlightenment. -Dr. Nikola Tesla
