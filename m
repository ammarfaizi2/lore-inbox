Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264626AbSJOKUu>; Tue, 15 Oct 2002 06:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264640AbSJOKUu>; Tue, 15 Oct 2002 06:20:50 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:8352 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264626AbSJOKUt>; Tue, 15 Oct 2002 06:20:49 -0400
To: tytso@mit.edu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
References: <E181IS8-0001DQ-00@snap.thunk.org>
From: Olaf Dietsche 
	<olaf.dietsche#list.linux-kernel-patches@t-online.de>
Date: Tue, 15 Oct 2002 12:26:16 +0200
Message-ID: <87of9wngl3.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tytso@mit.edu writes:

> 	Enclosed please find patches to add extended attribute support
> to the ext2 and ext3 filesystems.  It is a port of Andreas Gruenbacher's
> patches, which have been quite well tested at this point.  Full support
> for extended attributes have been in e2fsprogs for quite some time.  In
> addition, if CONFIG_EXT[23]_FS_ATTR is not enabled, the code path
> changes are quite minimal, and hence this should be a very low-risk
> patch.  Please apply.

Maybe this is a stupid question. Does this mean, fs capabilities will
come too?

Regards, Olaf.
