Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291494AbSBACpv>; Thu, 31 Jan 2002 21:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291495AbSBACpn>; Thu, 31 Jan 2002 21:45:43 -0500
Received: from ns.suse.de ([213.95.15.193]:49924 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291494AbSBACp2>;
	Thu, 31 Jan 2002 21:45:28 -0500
Date: Fri, 1 Feb 2002 03:45:27 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: <rwhron@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops immediately following dbench 192 on 2.5.3
In-Reply-To: <20020201024337.GA5932@earthlink.net>
Message-ID: <Pine.LNX.4.33.0202010343320.14594-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2002 rwhron@earthlink.net wrote:

> System has reiserfs root filesystem and other filesystems, except
> for the ext2 filesystem that was running dbench 192.  IDE.

Does the patch Oleg posted earlier for 2.5.2-dj7 fix this problem ?
I was wondering why that bug was showing up in -dj but not mainline,
so I'm expecting it to solve your problem.

Subject was Re: Current Reiserfs Update / 2.5.2-dj7 Oops

(Or just grab the reiserfs changes from 2.5.3-dj1)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

