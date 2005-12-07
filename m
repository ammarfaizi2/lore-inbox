Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbVLGL3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbVLGL3Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 06:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbVLGL3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 06:29:16 -0500
Received: from krusty.dt.E-Technik.uni-dortmund.de ([129.217.163.1]:29925 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1750876AbVLGL3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 06:29:16 -0500
Date: Wed, 7 Dec 2005 12:29:09 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051207112909.GA4012@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain> <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe> <20051203225815.GH25722@merlin.emma.line.org> <87y82z5kep.fsf@mid.deneb.enyo.de> <1133816764.9356.72.camel@laptopd505.fenrus.org> <87mzjf2gxs.fsf@mid.deneb.enyo.de> <20051206112127.GE10574@merlin.emma.line.org> <d120d5000512060845l1d035f46ub8d9334b6936f9e7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000512060845l1d035f46ub8d9334b6936f9e7@mail.gmail.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2005, Dmitry Torokhov wrote:

> On 12/6/05, Matthias Andree <matthias.andree@gmx.de> wrote:
> >
> > QA has to happen at all levels if it is supposed to be affordable or
> > scalable. The development process was scaled up, but QA wasn't.
> >
> > How about the Signed-off-by: lines? Those people who pass on the changes
> > also pass on the bugs, and they are responsible for the code - not only
> > license-wise, but also quality-wise. That's the latest point where
> > regression tests MUST happen.
> 
> People who pass the changes can only test ones they have hardware for.
> For the rest they can try to validate the code by reading patches but
> have to rely on the submitter wrt to the patch actually working.

What I'm saying is that people (maintainer) should have a selected
number of people (users) test the patches before they are merged.

-- 
Matthias Andree
