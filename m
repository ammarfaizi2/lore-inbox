Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSFJBrS>; Sun, 9 Jun 2002 21:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSFJBrR>; Sun, 9 Jun 2002 21:47:17 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:15338 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S315214AbSFJBrR>; Sun, 9 Jun 2002 21:47:17 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>, christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <200206100101.g5A11i1480453@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 18:47:11 -0700
Message-Id: <1023673633.1659.48.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 18:01, Albert D. Cahalan wrote:
> You don't get a shared filesystem that way. Windows would
> not be able to see the files created by Linux. You'd get stuck
> using the ext2 resizer all the time. You couldn't even move
> a file from ext2 to vfat without having enough disk space for
> it in both places.

That's not any different than having seperate VFAT and ext2 partitions
in a standard dual-boot situation.

- Nicholas

