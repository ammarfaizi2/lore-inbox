Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280717AbRKOF3Y>; Thu, 15 Nov 2001 00:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280609AbRKOF3N>; Thu, 15 Nov 2001 00:29:13 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:1519 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S278911AbRKOF3J>;
	Thu, 15 Nov 2001 00:29:09 -0500
Date: Wed, 14 Nov 2001 21:58:22 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux kernel <linux-kernel@vger.kernel.org>,
        "Peter T. Breuer" <ptb@it.uc3m.es>, dalecki@evision.ag
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011114215822.X5739@lynx.no>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>,
	"Peter T. Breuer" <ptb@it.uc3m.es>, dalecki@evision.ag
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> <200111142041.fAEKfBN15594@oboe.it.uc3m.es> <20011114141639.P5739@lynx.no> <20011114204848.A3266@node0.opengeometry.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <20011114204848.A3266@node0.opengeometry.ca>; from opengeometry@yahoo.ca on Wed, Nov 14, 2001 at 08:48:48PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 14, 2001  20:48 -0500, William Park wrote:
> On Wed, Nov 14, 2001 at 02:16:39PM -0700, Andreas Dilger wrote:
> > > I at least am getting up to devicesizes at the 8TB range.
> > 
> > If you are in that ballpark, then get the 64-bit blocknumber patch,
> > and start testing/fixing, instead of complaining.
> 
> Hi Andreas, can you give us URL for this 64-bit patch?  I also want to
> go past 1TB (512 * 2^31) filesystem size.

I don't have it, try a search of the l-k archives, around June of this year.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

