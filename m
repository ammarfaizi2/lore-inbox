Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289159AbSA3MaI>; Wed, 30 Jan 2002 07:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289136AbSA3M36>; Wed, 30 Jan 2002 07:29:58 -0500
Received: from ns.suse.de ([213.95.15.193]:17 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289159AbSA3M3r>;
	Wed, 30 Jan 2002 07:29:47 -0500
Date: Wed, 30 Jan 2002 13:29:37 +0100
From: Dave Jones <davej@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130132937.A24012@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alexander Viro <viro@math.psu.edu>,
	Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0201300310330.11157-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 30, 2002 at 01:21:09AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 01:21:09AM -0800, Linus Torvalds wrote:
 > 
 > A "small stuff" maintainer may indeed be a good idea. The maintainer could
 > be the same as somebody who does bigger stuff too, but they should be
 > clearly different things - trivial one-liners that do not add anything
 > new, only fix obvious stuff (to the point where nobody even needs to think
 > about it - if I'd start getting any even halfway questionable patches from
 > the "small stuff" maintainer, it wouldn't work).

 The difficult part comes when slightly larger changesets are needed,
 just to make things compile again for some people.
 See yesterdays subsection changes from Keith I forwarded you for
 example. To me, it had looked fine, it had good discussion on
 l-k, and it solved a known problem. I was surprised you threw it
 back for more changes (but glad, I want the best solution too, and
 taking a quick glance to the mail I've not read yet, it looks like
 Keith has bettered his original solution).

 Most of the bits I've sent you so far have been "small stuff".
 And things will likely continue to be so. There are large chunks
 in my tree, but I've absolutely no intention of feeding you those.
 Things like the input layer/console layer reworking are the
 responsibility of $maintainer to push your way.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
