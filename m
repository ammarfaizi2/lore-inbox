Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268611AbTBZChf>; Tue, 25 Feb 2003 21:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268613AbTBZChf>; Tue, 25 Feb 2003 21:37:35 -0500
Received: from sullivan.realtime.net ([205.238.132.76]:62477 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id <S268611AbTBZChd>; Tue, 25 Feb 2003 21:37:33 -0500
Date: Tue, 25 Feb 2003 20:47:43 -0600 (CST)
Message-Id: <200302260247.h1Q2lhE42800@sullivan.realtime.net>
From: miltonm@bga.com
Subject: Re: Patch: 2.5.62 devfs shrink
In-Reply-To: 20030226005132.GA10511@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The real fix cset is below and was applied long ago (dated Jan 5), and indeed
reading carefully bugzilla #110

  "2.5.55 boots ok with no workarounds needed, but 2.5.54 fails"


akpm@digeo.com|ChangeSet|20030106035042|11703


1.879.2.22 03/01/05 19:50:42-08:00 akpm@digeo.com 15796 15795 00003/00000/00001

[PATCH] devfs mount-time readdir fix and cleanup


milton
