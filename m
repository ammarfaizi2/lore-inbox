Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265835AbUAPUgc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 15:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUAPUgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 15:36:31 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:14254 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S265835AbUAPUgF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 15:36:05 -0500
Message-ID: <40084B33.60209@comcast.net>
Date: Fri, 16 Jan 2004 14:36:03 -0600
From: Ian Pilcher <i.pilcher@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [IDEA] - run-length compaction of block numbers
References: <BAY1-F117hxeH6PC8MS00006f92@hotmail.com> <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>
In-Reply-To: <200401161954.i0GJsEgj003906@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> 
> On the other hand, dynamic allocation of inodes is interesting, as it means
> you're not screwed if over time, the NBPI value for the filesystem changes (or
> if you simply guessed wrong at mkfs time) and you run out of inodes when you
> still have space free.  Reiserfs V3 already does this, in fact...
> 

As does JFS.  Anyone know about XFS?

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

