Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267015AbSLKFBP>; Wed, 11 Dec 2002 00:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267016AbSLKFBP>; Wed, 11 Dec 2002 00:01:15 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:992 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267015AbSLKFBO>;
	Wed, 11 Dec 2002 00:01:14 -0500
Message-ID: <1039583335.3df6c8677cff4@kolivas.net>
Date: Wed, 11 Dec 2002 16:08:55 +1100
From: Con Kolivas <conman@kolivas.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@digeo.com>
Subject: Re:  Problem with mm1 patch for 2.5.51
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe said:
>EXT3-fs error (device ide0(3,6)) in ext3_delete_inode: Journal has aborted
etc..


I suspect I suffered a similar fate with the osdl test box. While I was away
letting it run a benchmark in smp mode the filesystem had remounted read only. I
tried rebooting to make some sense of what had happened but was unable to start
the machine with any kernel. I've asked the osdl people to have a look at the
box for me.

Previously a run in uniprocessor mode ran flawlessly.

Con
