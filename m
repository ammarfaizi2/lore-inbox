Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSFOLuN>; Sat, 15 Jun 2002 07:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSFOLuM>; Sat, 15 Jun 2002 07:50:12 -0400
Received: from ns.suse.de ([213.95.15.193]:45324 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315287AbSFOLuL>;
	Sat, 15 Jun 2002 07:50:11 -0400
Date: Sat, 15 Jun 2002 13:50:12 +0200
From: Dave Jones <davej@suse.de>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 IDE 91
Message-ID: <20020615135012.B16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>, rwhron@earthlink.net,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020615114106.GA30772@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2002 at 07:41:06AM -0400, rwhron@earthlink.net wrote:
 > > When the IDE carnage first started back circa 2.5.3, I had contemplated
 > > not merging *any* of the IDE patches, just so that people who want to
 > > work on other areas could have something solid to build upon.
 > > I regret not following through on that instinct.
 > 
 > I give the -dj series a vote of "good taste".   In my testing they have
 > been reliable.  Recently, 2.5.20-dj[34] completed all my tests, whereas
 > 2.5.{19,20,21} haven't.   I realize breakage in the development series
 > is expected and sometimes good.  Nonetheless, "two thumbs up" for -dj.

That's interesting. What exactly was failing ? It'd be in everyones
interests to get those bits pushed to Linus sooner.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
