Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbTIVUBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbTIVUBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:01:17 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:31496 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263090AbTIVUBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:01:14 -0400
Date: Mon, 22 Sep 2003 22:00:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Subject: Re: [PATCH] Add 'make uImage' for PPC32
Message-ID: <20030922200054.GB983@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
References: <20030922182928.GM7443@ip68-0-152-218.tc.ph.cox.net> <20030922190723.GN7443@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922190723.GN7443@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 12:07:23PM -0700, Tom Rini wrote:
> On Mon, Sep 22, 2003 at 11:29:28AM -0700, Tom Rini wrote:
> 
> > Hello.  The following BK patch adds support for a 'uImage' target on
> > PPC32.  This will create an image for the U-Boot (and formerly
> > PPCBoot) firmware.  The patch adds a scripts/mkuboot.sh as a wrapper for
> > the U-Boot mkimage program.  We put mkuboot.sh into scripts/ because
> > U-Boot works on a number of other platforms, and it's likely that they
> > will add a uImage target at some point.  Please apply.
> 
> And since I don't use U-Boot I didn't fully test this until I did the
> 2.6 forward port (coming soon), so the following is also needed to get
> all of the dependancies correct.  Please apply.

Could you please send normal looking patches.
I cannot follow the bk style (at least not at this time of the day).

	Sam
