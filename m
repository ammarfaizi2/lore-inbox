Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbTAHVi7>; Wed, 8 Jan 2003 16:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTAHVi7>; Wed, 8 Jan 2003 16:38:59 -0500
Received: from [81.2.122.30] ([81.2.122.30]:263 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267674AbTAHVi6>;
	Wed, 8 Jan 2003 16:38:58 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200301082147.h08Llfpp003623@darkstar.example.net>
Subject: Re: Undelete files on ext3 ??
To: Valdis.Kletnieks@vt.edu
Date: Wed, 8 Jan 2003 21:47:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301082133.h08LXlRA014406@turing-police.cc.vt.edu> from "Valdis.Kletnieks@vt.edu" at Jan 08, 2003 04:33:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What I was thinking of was a virtual device that allocated a new
> > sector whenever an old one was overwritten - kind of like a journaled
> > filesystem, but without the filesystem, (I.E. just the journal) :-).
> 
> $ DIR FOO.TXT;*
> FOO.TXT;1   FOO.TXT;2   FOO.TXT;2
> 
> VMS-style file versioning, anybody? ;)

Brilliant!

John.
