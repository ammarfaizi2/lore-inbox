Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135527AbRDSEoc>; Thu, 19 Apr 2001 00:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135546AbRDSEoO>; Thu, 19 Apr 2001 00:44:14 -0400
Received: from logic.net ([205.243.138.83]:43246 "HELO logic.net")
	by vger.kernel.org with SMTP id <S135527AbRDSEn6>;
	Thu, 19 Apr 2001 00:43:58 -0400
Date: Wed, 18 Apr 2001 23:36:18 -0500
From: "Edward S. Marshall" <esm@logic.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Richard Gooch <rgooch@atnf.csiro.au>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010418233618.A28546@labyrinth.local>
In-Reply-To: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU> <Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Thu, Apr 19, 2001 at 01:11:07AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 01:11:07AM -0300, Rik van Riel wrote:
> On Thu, 19 Apr 2001, Richard Gooch wrote:
> > esr wrote:
> > > CONFIG_DEVFS: Documentation/filesystems/devfs/ChangeLog
> > 
> > These are options that used to be used,
>     ....
> > These should not be removed
> 
> This makes no sense at all.  Do you have any particular
> reason for keeping this deadwood around ?

Look at the filename. ;-) They're not being kept around, they just happen
to be mentioned in the devfs ChangeLog, and esr's overzealous crossref
tool caught them. *grin*

Perhaps the tool should be modified to exempt comments in code and files
in Documentation/*? :-)

-- 
Edward S. Marshall <esm@logic.net>                http://www.nyx.net/~emarshal/
-------------------------------------------------------------------------------
[                  Felix qui potuit rerum cognoscere causas.                  ]
