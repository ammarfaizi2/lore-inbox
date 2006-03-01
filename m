Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbWCARjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbWCARjJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 12:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWCARjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 12:39:08 -0500
Received: from mail.gmx.de ([213.165.64.20]:65228 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932420AbWCARjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 12:39:06 -0500
X-Authenticated: #428038
Date: Wed, 1 Mar 2006 18:39:02 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: tao@acc.umu.se, twalberg@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060301173902.GA5209@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	tao@acc.umu.se, twalberg@mindspring.com,
	linux-kernel@vger.kernel.org
References: <43FDE983.nailFWR613JK4@burner> <20060223172346.GB31520@mindspring.com> <43FDF193.nailG0L117NIN@burner> <20060223175317.GD31520@mindspring.com> <43FEDB63.nailGCX2HX66G@burner> <20060225174410.GN20494@vasa.acc.umu.se> <20060228072431.GR20494@vasa.acc.umu.se> <44049ADE.nailC6L1ZUIFJ@burner> <20060228200108.GV20494@vasa.acc.umu.se> <4405C90F.nailCS133AUDA@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4405C90F.nailCS133AUDA@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-03-01:

> If you do not understand the diffeence between a useful warning (as with 
> cdrecord) and a warning that is a result of a severe bug caused by incorrect
> make file handling (as in GNU make) you are obviously  wrong here.

Continued offenses, rather than substantiating your claims.

This cosmetic GNU make bug that you've been ranting about for years,
which isn't a warning, has not, to my knowledge, caused any code to be
miscompiled. If you think otherwise, then you'll need to provide the GNU
make maintainers with such information so they are aware of the
severity.

However, until you can substantiate your claims, it's just Schilling's
usually offensive ranting and not a make "bug". Besides that, you can
just use "-include" to suppress the message. It even works in smake and
BSD make ...

-- 
Matthias Andree
