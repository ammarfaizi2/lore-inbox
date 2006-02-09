Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbWBIWiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbWBIWiq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 17:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWBIWiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 17:38:46 -0500
Received: from mail.gmx.net ([213.165.64.21]:22207 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750700AbWBIWip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 17:38:45 -0500
X-Authenticated: #428038
Date: Thu, 9 Feb 2006 23:38:40 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, jim@why.dont.jablowme.net,
       linux-kernel@vger.kernel.org, cdwrite@other.debian.org,
       acahalan@gmail.com
Subject: Re: [cdrtools PATCH (GPL)] Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060209223840.GB4590@merlin.emma.line.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>,
	jim@why.dont.jablowme.net, linux-kernel@vger.kernel.org,
	cdwrite@other.debian.org, acahalan@gmail.com
References: <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203182049.GB11083@merlin.emma.line.org> <43E3A19E.nail6A511N92B@burner> <20060203184240.GC11241@voodoo> <43E3AA95.nail6AV21A253@burner> <20060203192827.GC18533@merlin.emma.line.org> <20060208221305.GF2353@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060208221305.GF2353@ucw.cz>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2006, Pavel Machek wrote:

> > I just don't want my name tainted with accidents that happen during
> > integration because you don't have a recent Linux installation. The
> > RLIMIT_MEMLOCK was enough of an effort, my first patch would've worked,
> > too, hence the GPL.
> 
> Well, mailing patch with notice that it is not okay to modify it is
> strange behaviour, and if I was Joerg, I'd just drop that patch, too.

You have apparently missed that I offered to relicense the patch under
MIT license (which is liberal, allows modifications and everything)
after I'd confirmed the integration went OK; and I was just returning
the buck of being forced to change interface identifications all over
the map from "mustn't modify" sections.

The first step would be to look at the patch nonetheless, because it
conveys information that Jörg has not extracted from messages since the
first time SG_IO in ide-cd cropped up.

-- 
Matthias Andree
