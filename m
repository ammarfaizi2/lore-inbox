Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316732AbSERAl2>; Fri, 17 May 2002 20:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316730AbSERAl1>; Fri, 17 May 2002 20:41:27 -0400
Received: from waste.org ([209.173.204.2]:58536 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S316729AbSERAlZ>;
	Fri, 17 May 2002 20:41:25 -0400
Date: Fri, 17 May 2002 19:41:20 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: William Lee Irwin III <wli@holomorphy.com>,
        Andrew Morton <akpm@zip.com.au>, <Wayne.Brown@altec.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3
In-Reply-To: <Pine.LNX.4.44.0205171707510.26436-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0205171940000.28917-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Kai Germaschewski wrote:

> On Fri, 17 May 2002, William Lee Irwin III wrote:
>
> > On Fri, May 17, 2002 at 02:14:38PM -0700, Andrew Morton wrote:
> > > The deteriorating performance of gcc and the tendency of
> > > the current build system to needlessly recompile stuff are
> > > acute problems.  ccache saves me probably one hour per day.
> >
> > A build on my laptop takes well over an hour. This is not useful
> > for actually getting things done. I'm all for mitigating build
> > time in such cases, by kbuild-2.5 and perhaps other methods.
>
> I suppose you want ccache then. kbuild-2.5 may save two minutes of your
> one hour build.

That's assuming you have to build from scratch. The whole point is to
reduce the need to do that by making dependencies more accurate.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

