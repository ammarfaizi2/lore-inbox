Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316039AbSEZMsi>; Sun, 26 May 2002 08:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316050AbSEZMsh>; Sun, 26 May 2002 08:48:37 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:62646 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316039AbSEZMsg>;
	Sun, 26 May 2002 08:48:36 -0400
Date: Sun, 26 May 2002 14:48:20 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andre Hedrick <andre@linux-ide.org>,
        Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] New driver for Artop [Acard] controllers.
Message-ID: <20020526144820.A17158@ucw.cz>
In-Reply-To: <20020526130547.A16548@ucw.cz> <Pine.LNX.4.44.0205261334250.11662-100000@sharra.ivimey.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 26, 2002 at 01:42:51PM +0100, Ruth Ivimey-Cook wrote:

> On Sun, 26 May 2002, Vojtech Pavlik wrote:
> >On Fri, May 24, 2002 at 10:07:36PM -0700, Andre Hedrick wrote:
> >> Where do you get off delete copyrights?
> >> GPL permits changing it does not give you the right to steal, lie, cheat,
> >> defraud, other peoples work.  However I should not expect anything of
> >> honor from a person of your high morals.  I know you want to rewrite the
> >> past to make it so I and other never existed, but you are pathetic.
> >
> >I don't delete copyrights, where applicable. However, in this case, none
> >of the original code stayed, not a single line - I first wrote a spec
> >based on the old driver and then wrote a new driver from scratch based
> >on that spec. So, you really don't have a copyright on the new Artop
> >driver, sorry.
> 
> Vojtech,
> 
> It would be a lot better if you had acknowledged the prior input of the
> original writers in the source; I accept that if you write a new driver you
> are entitled to claim (C) on it, but to acknowledge the source of the
> specification would have been much fairer to the others whose hard work you
> have used.

Yes, I agree. That's why there is:

 *  Based on the work of:
 *     Andre Hedrick

in the new driver.

-- 
Vojtech Pavlik
SuSE Labs
