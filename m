Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTFIUVM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTFIUVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:21:12 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:42970 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S261801AbTFIUVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:21:06 -0400
Date: Mon, 9 Jun 2003 17:32:23 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.4.22 timeline was RE: 2.4.21-rc7 ACPI broken
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F25@orsmsx401.jf.intel.com>
Message-ID: <Pine.LNX.4.55L.0306091730310.26529@freak.distro.conectiva>
References: <F760B14C9561B941B89469F59BA3A847E96F25@orsmsx401.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 4 Jun 2003, Grover, Andrew wrote:

> > From: Grzegorz Jaskiewicz [mailto:gj@pointblue.com.pl]
> > > > ACPI: Core Subsystem version [20011018]
> > >
> > > Old ACPI code, get patch from http://sf.net/projects/acpi
> > and report back
> > > if problems persist.
> > Any chance to get patch against latest -rc7 ?
>
> It's big, and deemed too risky. We are shooting for 2.4.22-pre1.

Just had a few thoughts about that and I want to have a fast 2.4.22
release (maximum two months). 2.4.21's development time was unnaceptable.

Lets do the ACPI merge in 2.4.23.

