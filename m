Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267922AbTAHVqN>; Wed, 8 Jan 2003 16:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTAHVqN>; Wed, 8 Jan 2003 16:46:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:8164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267922AbTAHVqM>;
	Wed, 8 Jan 2003 16:46:12 -0500
Date: Wed, 8 Jan 2003 13:51:18 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: John Bradford <john@grabjohn.com>
cc: <Valdis.Kletnieks@vt.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Undelete files on ext3 ??
In-Reply-To: <200301082147.h08Llfpp003623@darkstar.example.net>
Message-ID: <Pine.LNX.4.33L2.0301081351010.6873-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jan 2003, John Bradford wrote:

| > > What I was thinking of was a virtual device that allocated a new
| > > sector whenever an old one was overwritten - kind of like a journaled
| > > filesystem, but without the filesystem, (I.E. just the journal) :-).
| >
| > $ DIR FOO.TXT;*
| > FOO.TXT;1   FOO.TXT;2   FOO.TXT;2
| >
| > VMS-style file versioning, anybody? ;)
|
| Brilliant!

re-read the archives from 6-8 months ago.

-- 
~Randy

