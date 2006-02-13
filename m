Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWBMXRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWBMXRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030271AbWBMXRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:17:34 -0500
Received: from smtp.enter.net ([216.193.128.24]:58887 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030269AbWBMXRd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:17:33 -0500
From: "D. Hazelton" <dhazelton@enter.net>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Mon, 13 Feb 2006 18:26:39 -0500
User-Agent: KMail/1.8.1
Cc: matthias.andree@gmx.de, linux-kernel@vger.kernel.org
References: <20060208162828.GA17534@voodoo> <20060213135240.GD10566@merlin.emma.line.org> <43F0A298.nailKUSW190PU@burner>
In-Reply-To: <43F0A298.nailKUSW190PU@burner>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131826.40281.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 10:15, Joerg Schilling wrote:
> Matthias Andree <matthias.andree@gmx.de> wrote:
> > > For this reason, it is bejond the scope of the Linux kernel team to
> > > decide on this abstraction layer. The Linux kernel team just need to
> > > take the current libscg interface as given as _this_  _is_ the way to
> > > do best abstraction.
> >
> > This is ridiculous. The abstraction (SG_IO on an open special file) is
> > in the kernel. Feel free to stack as many layers on top as you wish, but
> > the kernel isn't going to bend just to support a random abstraction
> > library that cannot achieve its goals in its current form anyways.
>
> Try to inform yourself on the difference between an IOCTL and a /dev/
> entry.

I believe he did make the distinction there. He states "The abstraction (SG_IO 
on an open special file) is in the kernel." An "open special file" could be 
anything, but in this case it's meant to refer to a /dev/ entry. The point he 
made is valid, and it appears that in this case, Joerg, you are the one who 
is "technically uninformed".

DRH
