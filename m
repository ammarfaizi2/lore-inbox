Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316820AbSFJLGt>; Mon, 10 Jun 2002 07:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316826AbSFJLGs>; Mon, 10 Jun 2002 07:06:48 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:20459 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S316820AbSFJLGr>;
	Mon, 10 Jun 2002 07:06:47 -0400
Date: Mon, 10 Jun 2002 13:06:41 +0200
From: Jan Pazdziora <adelton@informatics.muni.cz>
To: christoph@lameter.com
Cc: Nicholas Miell <nmiell@attbi.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Jan Pazdziora <adelton@informatics.muni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
Message-ID: <20020610130641.H13232@anxur.fi.muni.cz>
In-Reply-To: <1023648813.1188.19.camel@entropy> <Pine.LNX.4.33.0206091457230.17808-100000@melchi.fuller.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 03:02:10PM -0700, christoph@lameter.com wrote:
> 
> Only the .lnk files that can be properly interpreted as symlinks are
> showing up as symlink as far as I can tell. This is quite ok and very

Right.

> helpful. .lnk file interpretation can be switched off and on as a boot
> option.

Umm, mount option.

> vfat with the patch can *create* symlinks that are compatible with other
> oses.
> 
> The patch is a must have ....

I'll try to update the patch for latest kernel versions so that we're
talking current code.

Yours,

-- 
------------------------------------------------------------------------
  Jan Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
      ... all of these signs saying sorry but we're closed ...
------------------------------------------------------------------------
