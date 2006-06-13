Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWFMIfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWFMIfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 04:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWFMIfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 04:35:48 -0400
Received: from ns.firmix.at ([62.141.48.66]:1697 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1750774AbWFMIfr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 04:35:47 -0400
Subject: Re: VGER does gradual SPF activation (FAQ matter)
From: Bernd Petrovitsch <bernd@firmix.at>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: marty fouts <mf.danger@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
       Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606130305.k5D35YhA004268@laptop11.inf.utfsm.cl>
References: <200606130305.k5D35YhA004268@laptop11.inf.utfsm.cl>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Tue, 13 Jun 2006 10:31:18 +0200
Message-Id: <1150187478.28123.7.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.334 () AWL,BAYES_00,FORGED_RCVD_HELO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 23:05 -0400, Horst von Brand wrote:
> Bernd Petrovitsch <bernd@firmix.at> wrote:
[...]
> > Use secure authenticated mail submission on a known good MTA of said
> > domain (and even the smallest ISP should be able to set that up).
> 
> So what? What should me make me trust some domain that I've never before

Well, so everyone can send email through an MTA (the email accounts
"home MTA") covered in the SPF records.

> heard of is correctly set up? No, "package it up so the dumbest admin on

What makes you believe that the domains you heard of are setup
correctly?
Of course for some/several/many of them you know (because you or
trustfully people administrate them or the domain setup look like sane
to the rest of the world), but for other (including "well known")
domains and in the long run?

If the point was: "We want tolerate ill-adminned domains."
That depends on the error hypotheses and which ill behaviour one wants
to tolerate ......

> Earth can set it up" helps not an iota, they sure will.

I'm not designing (or propagating) anything for dumb admins (they will
screw up anything anyways and an admin knows per definition what s/he is
doing) but it is enough for sane (but also overloaded - so it should not
be too much of a hassle) admins.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

