Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRD2U2X>; Sun, 29 Apr 2001 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136330AbRD2U2O>; Sun, 29 Apr 2001 16:28:14 -0400
Received: from 13dyn119.delft.casema.net ([212.64.76.119]:59653 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131481AbRD2U1L>; Sun, 29 Apr 2001 16:27:11 -0400
Message-Id: <200104292027.WAA25283@cave.bitwizard.nl>
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <3AEC76E1.EF589359@transmeta.com> from "H. Peter Anvin" at "Apr
 29, 2001 01:17:37 pm"
To: "H. Peter Anvin" <hpa@transmeta.com>
Date: Sun, 29 Apr 2001 22:27:08 +0200 (MEST)
CC: Gregory Maxwell <greg@linuxpower.cx>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Gregory Maxwell wrote:
> > >
> > > I doubt the kernel is seeing it without it being there (it doesn't have
> > > much imagination.)  However, it may very well be there in a funny
> > > manner.  You do realize, of course, that it's pretty much impossible for
> > > us to help you answer that question without a complete dump of the
> > > filesystem on hand, I hope?
> > 
> > He gave what he thought was a complete dump of the non-null bytes. The
> > obvious answer is that he's looking wrong. :)
> > 
> 
> Hence the "complete" part...

OK. 

The image of the disk (including partition table) is at:

	ftp://ftp.bitwizard.nl/misc_junk/formatted.img.gz

It's 63kb and uncompresses to the 64Mb (almost) that it's sold as.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
