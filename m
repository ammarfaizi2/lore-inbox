Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWFMKu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWFMKu1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 06:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbWFMKu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 06:50:27 -0400
Received: from mail.gmx.net ([213.165.64.21]:20973 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750926AbWFMKu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 06:50:26 -0400
X-Authenticated: #428038
Date: Tue, 13 Jun 2006 12:50:21 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Bernd Petrovitsch <bernd@firmix.at>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, marty fouts <mf.danger@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
Message-ID: <20060613105021.GB13597@merlin.emma.line.org>
Mail-Followup-To: Bernd Petrovitsch <bernd@firmix.at>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	marty fouts <mf.danger@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matti Aarnio <matti.aarnio@zmailer.org>,
	linux-kernel@vger.kernel.org
References: <200606130305.k5D35YhA004268@laptop11.inf.utfsm.cl> <1150187478.28123.7.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150187478.28123.7.camel@tara.firmix.at>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11-2006-06-08
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Petrovitsch schrieb am 2006-06-13:

> On Mon, 2006-06-12 at 23:05 -0400, Horst von Brand wrote:
> > Bernd Petrovitsch <bernd@firmix.at> wrote:
> [...]
> > > Use secure authenticated mail submission on a known good MTA of said
> > > domain (and even the smallest ISP should be able to set that up).
> > 
> > So what? What should me make me trust some domain that I've never before
> 
> Well, so everyone can send email through an MTA (the email accounts
> "home MTA") covered in the SPF records.

As (1) SPF this is demonstrably useless to establish trust and (2) the
argument that SPF doesn't provide the required blacklist information
hasn't been countered yet, it follows that
SPF just makes life harder for everyone without real benefits in return.

SPF also prefers end-to-end mailings and falls short when relays are
used - but these are advocated by the SPF disciples.

Can this SPF madness please be buried now?

-- 
Matthias Andree
