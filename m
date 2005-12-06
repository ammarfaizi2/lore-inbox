Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbVLFLVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbVLFLVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbVLFLVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:21:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:64738 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750798AbVLFLVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:21:37 -0500
X-Authenticated: #428038
Date: Tue, 6 Dec 2005 12:21:27 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206112127.GE10574@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <1133620264.2171.14.camel@localhost.localdomain> <20051203193538.GM31395@stusta.de> <1133639835.16836.24.camel@mindpipe> <20051203225815.GH25722@merlin.emma.line.org> <87y82z5kep.fsf@mid.deneb.enyo.de> <1133816764.9356.72.camel@laptopd505.fenrus.org> <87mzjf2gxs.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mzjf2gxs.fsf@mid.deneb.enyo.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2005, Florian Weimer wrote:

> From a vendor POV, the lack of official kernel.org advisories may be a
> feature.  I find it rather disturbing, and I'm puzzled that the kernel
> developer community doesn't view this a problem.  I know I'm alone,

You're not alone in viewing this as a problem, but QA is a burden kernel
developers are not interested in. But it is necessary.

QA has to happen at all levels if it is supposed to be affordable or
scalable. The development process was scaled up, but QA wasn't.

How about the Signed-off-by: lines? Those people who pass on the changes
also pass on the bugs, and they are responsible for the code - not only
license-wise, but also quality-wise. That's the latest point where
regression tests MUST happen.

-- 
Matthias Andree
