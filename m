Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261532AbSKCAul>; Sat, 2 Nov 2002 19:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSKCAul>; Sat, 2 Nov 2002 19:50:41 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:38595 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261532AbSKCAuk>; Sat, 2 Nov 2002 19:50:40 -0500
Cc: "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>,
       <davej@suse.de>
References: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sun, 03 Nov 2002 01:56:50 +0100
In-Reply-To: <Pine.LNX.4.44.0211021025420.2413-100000@home.transmeta.com> (Linus
 Torvalds's message of "Sat, 2 Nov 2002 10:47:07 -0800 (PST)")
Message-ID: <87y98bxygd.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

>  - Make a new file type, and put just that information in the directory
>    (so that it shows up in d_type on a readdir()).  Put the real data in
>    the file, ie make it largely look like an "extended symlink".

How would you go from a regular file to the new extended symlink?

Regards, Olaf.
