Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261407AbSJMDD0>; Sat, 12 Oct 2002 23:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261409AbSJMDDZ>; Sat, 12 Oct 2002 23:03:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17350 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261407AbSJMDDZ>;
	Sat, 12 Oct 2002 23:03:25 -0400
Date: Sat, 12 Oct 2002 20:07:30 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] configurable corename
In-Reply-To: <200210130209.g9D29it02709@hera.kernel.org>
Message-ID: <Pine.LNX.4.33L2.0210122002480.11896-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Linux Kernel Mailing List wrote:

| ChangeSet 1.824, 2002/10/12 17:19:08-07:00, alan@lxorguk.ukuu.org.uk
|
| 	[PATCH] configurable corename
|
| 	To my suprise a lot of big site/beowulf type people all really want this
| 	diff, which I'd otherwise filed as 'interesting but not important'
|
|
| # This patch includes the following deltas:
| #	           ChangeSet	1.823   -> 1.824
| #	include/linux/sysctl.h	1.30    -> 1.31
| #	     kernel/sysctl.c	1.31    -> 1.32
| #	           fs/exec.c	1.49    -> 1.50

a additional patch to linux/Documentation/{core|dump}.txt (e.g.)
or Documentation/sysctl/kernel.txt sure would be nice.  :)

-- 
~Randy
  "In general, avoiding problems is better than solving them."
  -- from "#ifdef Considered Harmful", Spencer & Collyer, USENIX 1992.

