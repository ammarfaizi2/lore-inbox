Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316912AbSFKIC6>; Tue, 11 Jun 2002 04:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSFKIC5>; Tue, 11 Jun 2002 04:02:57 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:5650 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S316912AbSFKICz>; Tue, 11 Jun 2002 04:02:55 -0400
Date: Mon, 10 Jun 2002 20:47:26 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 kill warinigs 14/19
Message-ID: <20020610204726.A681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D049157.3040600@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 01:45:27PM +0200, Martin Dalecki wrote:
> irlap_frame this time. Let me guess they used emacs?!

The better way to solve this is to include:

/*
 * Overrides for Emacs so that we follow Linus's tabbing style.
 * Emacs will notice this stuff at the end of the file and automatically
 * adjust the settings for this buffer only.  This must remain at the end
 * of the file.
 * ---------------------------------------------------------------------------
 * Local variables:
 * c-indent-level: 8
 * c-brace-imaginary-offset: 0
 * c-brace-offset: -8
 * c-argdecl-indent: 8
 * c-label-offset: -8
 * c-continued-statement-offset: 8
 * c-continued-brace-offset: 0
 * End:
 */

at the end of each file these people who cannot use their editor touch.

That's how I solved it with my own team mates ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
