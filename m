Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313508AbSFIQqQ>; Sun, 9 Jun 2002 12:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSFIQqP>; Sun, 9 Jun 2002 12:46:15 -0400
Received: from relay.muni.cz ([147.251.4.35]:23204 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S313508AbSFIQqP>;
	Sun, 9 Jun 2002 12:46:15 -0400
Date: Sun, 9 Jun 2002 18:44:35 +0200
From: Jan Pazdziora <adelton@informatics.muni.cz>
To: christoph@lameter.com
Cc: linux-kernel@vger.rutgers.edu, adelton@fi.muni.cz
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <20020609184435.A27442@anxur.fi.muni.cz>
In-Reply-To: <Pine.LNX.4.33.0206081849010.5464-100000@melchi.fuller.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2002 at 06:53:49PM -0700, christoph@lameter.com wrote:
> I just tried the patch adding symlinks to the vfat fs. It was submitted
> back at the end of last year but it does not seem to have made it into the
> kernel sources. I was unable to find a discussion on this. Symlink support
> in vfat is really useful when you are sharing a vfat volume on a dual
> booted system. I tried patching a 2.5.X kernel but the page cache changes
> mean that the patch needs reworking.
> 
> Do you have any updates to the patch Jan?

No, I don't. I did not receive any feedback since I sent in the patch
to linux-kernel, so I concluded that people do not consider lack
of shortcut/symlink support a problem. For me it's something that
would be nice to have but I don't feel like pushing it in.

I might be able to upgrade the patch for the 2.5 kernal line, but
I'd like to hear some comments about the code in general. 

Yours,

-- 
------------------------------------------------------------------------
  Jan Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
      ... all of these signs saying sorry but we're closed ...
------------------------------------------------------------------------
