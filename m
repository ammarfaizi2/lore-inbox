Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313947AbSEFAmG>; Sun, 5 May 2002 20:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313996AbSEFAmF>; Sun, 5 May 2002 20:42:05 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:60400
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S313947AbSEFAmF>; Sun, 5 May 2002 20:42:05 -0400
Date: Sun, 5 May 2002 17:42:04 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020506004204.GJ2392@matchmail.com>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <slrnad4o8c.hbt.kraxel@bytesex.org> <11028.1020422524@ocs3.intra.ocs.com.au> <15571.33592.365558.215598@argo.ozlabs.ibm.com> <15571.38378.376365.3387@argo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 06:03:54PM +1000, Paul Mackerras wrote:
> I still think that the time to build the global makefile is big enough
> and obvious enough that many people (including myself) will want to
> see it optimized, either by making the process itself more efficient
> or by caching the result and re-using it where possible.

But it's still faster than kbuild-2.4.

This shouldn't keep it from going into mainline.  Just like anything else,
the itch will be scratched if there's enough irritation, and inclusion of
the new kbuild should at first *reduce* the irritation that's already there
now.
