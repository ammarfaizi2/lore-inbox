Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTFIVb6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 17:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTFIVb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 17:31:57 -0400
Received: from pointblue.com.pl ([62.89.73.6]:8972 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262148AbTFIVbS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 17:31:18 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
Date: Mon, 9 Jun 2003 22:24:20 +0100
User-Agent: KMail/1.5.2
References: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A2DF@orsmsx401.jf.intel.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Guy Therien <guy.therien@intel.com>, Len Brown <len.brown@intel.com>,
       Sunil Saxena <sunil.saxena@intel.com>,
       Andrew Grover <andrew.grover@intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306092224.32663@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Monday 09 of June 2003 22:21, you wrote:
> > From: Marcelo Tosatti [mailto:marcelo@conectiva.com.br]
> >
> > > > Any chance to get patch against latest -rc7 ?
> > >
> > > It's big, and deemed too risky. We are shooting for 2.4.22-pre1.
> >
> > Just had a few thoughts about that and I want to have a fast 2.4.22
> > release (maximum two months). 2.4.21's development time was
> > unnaceptable.
In this world there should be no rush :-)

> > Lets do the ACPI merge in 2.4.23.
>
> I wouldn't have a problem with this, except that you've been deferring
> the ACPI merge for over a year. We've been maintaining this patch
> outside the mainline tree for EIGHTEEN MONTHS. Please stop leading me
> along. Will you EVER merge it?
>
> I am confident it will merge cleanly.
> I am confident it will cause no problems when CONFIG_ACPI=off.
> I am confident the total number of working machines will go up.
> I am willing to bet $500 of MY OWN MONEY on this.

Well, Marcelo - i am happy with new ACPI, Alan does (otherwise it wouldn't be 
included into ac tree). We will welcome it in 2.4.22-pre1 :]

Anyway, still ACPI does not work fully in my PCG-C1VE Sony Vaio. I don't know 
if due to incompatibilities of this equipment ?
All other servers/desktops works perfectly fine for me :D

Thanks guys. 
- --
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5PsLqu082fCQYIgRAuaFAJ0RxLG8gj2/Lk2B+bxS7bxwcve4zgCghgzO
d7hfwJa81RyJ+ltxmBd+KIs=
=JkND
-----END PGP SIGNATURE-----

