Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277055AbRJRCIC>; Wed, 17 Oct 2001 22:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277554AbRJRCHx>; Wed, 17 Oct 2001 22:07:53 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:4356 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S277055AbRJRCHo>;
	Wed, 17 Oct 2001 22:07:44 -0400
Date: Thu, 18 Oct 2001 10:58:08 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Charles Briscoe-Smith <charles@briscoe-smith.org.uk>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] to tidy up some orinoco driver log messages
Message-ID: <20011018105808.X11355@zax>
Mail-Followup-To: David Gibson <hermes@gibson.dropbear.id.au>,
	Charles Briscoe-Smith <charles@briscoe-smith.org.uk>,
	Jean Tourrilhes <jt@hpl.hp.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011018012734.A2802@merry.bs.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011018012734.A2802@merry.bs.lan>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 01:27:34AM +0100, Charles Briscoe-Smith wrote:
> This trivial patch cleans up a few missing newlines in some log messages
> in the Orinoco driver.  Generated from linux-2.4.12 (orinoco.c 0.08a);
> should apply cleanly to linux-2.4.13-pre3.

Thanks. Merged.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

