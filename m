Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSGNR4c>; Sun, 14 Jul 2002 13:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316988AbSGNR4b>; Sun, 14 Jul 2002 13:56:31 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:4277 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316978AbSGNR4a>;
	Sun, 14 Jul 2002 13:56:30 -0400
Date: Sun, 14 Jul 2002 19:59:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Andries Brouwer <aebr@win.tue.nl>,
       A Guy Called Tyketto <tyketto@wizard.com>, linux-kernel@vger.kernel.org
Subject: Re: kbd not functioning in 2.5.25-dj2
Message-ID: <20020714195902.D27798@ucw.cz>
References: <20020714143702.A26584@ucw.cz> <200207141336.PAA01395@cave.bitwizard.nl> <20020714193236.A27798@ucw.cz> <20020714184954.A3637@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020714184954.A3637@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Sun, Jul 14, 2002 at 06:49:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 06:49:54PM +0100, Russell King wrote:

> On Sun, Jul 14, 2002 at 07:32:36PM +0200, Vojtech Pavlik wrote:
> > Yes. Sure. I knew someone will suggest that. :) The only problem is,
> > I've never seen a keyboard sending 0xfe because it wants the command
> > sent again. Under normal circumstances, there aren't bit errors on the
> > cable.
> 
> I think you missed my mail at the beginning of this thread.

I read it. Well, let's first see where the 0xfe really comes from. :)

-- 
Vojtech Pavlik
SuSE Labs
