Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318563AbSHLCLV>; Sun, 11 Aug 2002 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318564AbSHLCLV>; Sun, 11 Aug 2002 22:11:21 -0400
Received: from web40304.mail.yahoo.com ([66.218.78.83]:58927 "HELO
	web40304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S318563AbSHLCLV>; Sun, 11 Aug 2002 22:11:21 -0400
Message-ID: <20020812021504.45996.qmail@web40304.mail.yahoo.com>
Date: Sun, 11 Aug 2002 19:15:04 -0700 (PDT)
From: Studying MTD <studying_mtd@yahoo.com>
Subject: READ/WRITE multiple blocks
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to Read/Write multiple blocks for a block
device.

I have set max_sectors to 10 but how can i know that
block driver is reading/writing 10 blocks per request.

Thanks for your help.


__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
