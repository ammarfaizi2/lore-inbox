Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313447AbSDGTlb>; Sun, 7 Apr 2002 15:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313448AbSDGTla>; Sun, 7 Apr 2002 15:41:30 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:36370 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S313447AbSDGTl1>; Sun, 7 Apr 2002 15:41:27 -0400
Date: Sun, 7 Apr 2002 20:41:14 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Steven N. Hirsch" <shirsch@adelphia.net>, linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407194114.GA21800@compsoc.man.ac.uk>
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> <E16uIf7-0006Zw-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16uIXP-0007QL-00*32bPFtgK2/Y* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 08:49:17PM +0100, Alan Cox wrote:

> Removing it in the -ac tree is a good way to stimulate discussion

OK

> fixing the code that relies on it (except for the 99% of code relying on it
> which is cracker authored trojans)

No doubt, but it's not much harder to look at nm vmlinux or System.map,
so I don't see the security angle...

I'd be happy to bear the brunt of users moaning at me because they now
have to apply a kernel patch (and I have to maintain it ...), iff there
was some strongly technical reason the code has to change.

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
