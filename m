Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSFJCGo>; Sun, 9 Jun 2002 22:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSFJCGn>; Sun, 9 Jun 2002 22:06:43 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:749 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S316182AbSFJCGn>; Sun, 9 Jun 2002 22:06:43 -0400
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
From: Nicholas Miell <nmiell@attbi.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>, christoph@lameter.com,
        linux-kernel@vger.kernel.org, adelton@fi.muni.cz
In-Reply-To: <200206100158.g5A1wMk522000@saturn.cs.uml.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Jun 2002 19:06:37 -0700
Message-Id: <1023674799.1518.54.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-09 at 18:58, Albert D. Cahalan wrote:
> > That's not any different than having seperate VFAT and ext2
> > partitions in a standard dual-boot situation.
> 
> Sure. That obviously sucks; Linux can do better.
> It's important to make a transition to Linux as
> painless as possible. Nobody considering an OS
> change likes the feeling that their data files
> are trapped on one side or the other.

Huh? Windows can access files on VFAT and Linux can access files on
VFAT. How are they "trapped"?

- Nicholas

