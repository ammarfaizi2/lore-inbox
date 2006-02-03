Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWBCSfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWBCSfr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbWBCSfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:35:47 -0500
Received: from atpro.com ([12.161.0.3]:8453 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S964780AbWBCSfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:35:46 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Fri, 3 Feb 2006 13:35:30 -0500
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, acahalan@gmail.com,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, j@bitron.ch
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203183530.GA11241@voodoo>
Mail-Followup-To: Krzysztof Halasa <khc@pm.waw.pl>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, acahalan@gmail.com,
	mrmacman_g4@mac.com, matthias.andree@gmx.de,
	linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
	James@superbug.co.uk, j@bitron.ch
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo> <m3hd7ge3j2.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3hd7ge3j2.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/06 06:49:21PM +0100, Krzysztof Halasa wrote:
> "Jim Crilly" <jim@why.dont.jablowme.net> writes:
> 
> > A bug in HAL is not a bug in Linux. If the HAL people need to make some
> > changes to their daemon to make it play nice with cdrecord and the like
> > that's fine, but telling people here makes no sense.
> 
> Does that mean that hald doesn't actually play nice with cdrecord?
> -- 
> Krzysztof Halasa
> -

That's what the bug reports in Debian and Ubuntu say, the periodic polling
that hald does on the CD devices causes interruptions in the burning
process.

Jim.
