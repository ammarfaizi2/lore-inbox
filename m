Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279963AbRKOBuK>; Wed, 14 Nov 2001 20:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279998AbRKOBt4>; Wed, 14 Nov 2001 20:49:56 -0500
Received: from ppp-RAS1-1-87.dialup.eol.ca ([64.56.224.87]:26631 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S279963AbRKOBtC>; Wed, 14 Nov 2001 20:49:02 -0500
Date: Wed, 14 Nov 2001 20:48:48 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux kernel <linux-kernel@vger.kernel.org>
Cc: "Peter T. Breuer" <ptb@it.uc3m.es>, dalecki@evision.ag
Subject: Re: blocks or KB? (was: .. current meaning of blk_size array)
Message-ID: <20011114204848.A3266@node0.opengeometry.ca>
Mail-Followup-To: linux kernel <linux-kernel@vger.kernel.org>,
	"Peter T. Breuer" <ptb@it.uc3m.es>, dalecki@evision.ag
In-Reply-To: <3BF23D01.F7E879E8@evision-ventures.com> <200111142041.fAEKfBN15594@oboe.it.uc3m.es> <20011114141639.P5739@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011114141639.P5739@lynx.no>; from adilger@turbolabs.com on Wed, Nov 14, 2001 at 02:16:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 02:16:39PM -0700, Andreas Dilger wrote:
> > I at least am getting up to devicesizes at the 8TB range.
> 
> If you are in that ballpark, then get the 64-bit blocknumber patch,
> and start testing/fixing, instead of complaining.
> 
> Cheers, Andreas

Hi Andreas, can you give us URL for this 64-bit patch?  I also want to
go past 1TB (512 * 2^31) filesystem size.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>.
8 CPU cluster, NAS, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Tin
