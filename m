Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbTFIVwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTFIVwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:52:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:65154 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262171AbTFIVwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:52:10 -0400
Date: Mon, 9 Jun 2003 19:03:29 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       "Therien, Guy" <guy.therien@intel.com>
Subject: RE: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.55L.0306091901260.27584@freak.distro.conectiva>
References: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 Jun 2003, Grover, Andrew wrote:

> > From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br]
> > > > Any chance to get patch against latest -rc7 ?
> > >
> > > It's big, and deemed too risky. We are shooting for 2.4.22-pre1.
> >
> > Just had a few thoughts about that and I want to have a fast 2.4.22
> > release (maximum two months). 2.4.21's development time was
> > unnaceptable.
> >
> > Lets do the ACPI merge in 2.4.23.
>
> I wouldn't have a problem with this, except that you've been deferring
> the ACPI merge for over a year. We've been maintaining this patch
> outside the mainline tree for EIGHTEEN MONTHS.

The main reason I didnt want to merge it was due to its size. Its just too
big.

> Please stop leading me along. Will you EVER merge it?

Yes, I want to, and will merge it. In 2.4.23-pre.

> I am confident it will merge cleanly.
> I am confident it will cause no problems when CONFIG_ACPI=off.
> I am confident the total number of working machines will go up.
> I am willing to bet $500 of MY OWN MONEY on this.
>
> Talk to me, man. What would make you happy? A lot is riding on this.

Yes, we're fine. 2.4.23-pre.

2.4.22 will be a fast enough release to not piss you off on this, trust
me.
