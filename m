Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269063AbUJENiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269063AbUJENiA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269087AbUJENiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:38:00 -0400
Received: from pD9562698.dip.t-dialin.net ([217.86.38.152]:50520 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S269063AbUJENhq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:37:46 -0400
Date: Tue, 5 Oct 2004 15:36:52 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
       kernel-janitors@lists.osdl.org, greg@kroah.com,
       linux-mips@linux-mips.org
Subject: Re: [PATCH 2.6] pci-hplj.c: replace pci_find_device with pci_get_device
Message-ID: <20041005133652.GA17520@linux-mips.org>
References: <281940000.1096925207@w-hlinder.beaverton.ibm.com> <20041004214107.GA2160@linux-mips.org> <1096981395.30942.859.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1096981395.30942.859.camel@hades.cambridge.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 02:03:16PM +0100, David Woodhouse wrote:

> On Mon, 2004-10-04 at 23:41 +0200, Ralf Baechle wrote:
> > Except that piece of code isn't for an RM[23]00 but a HP Laserjet (yes,
> > that paper eating thing ;-) and hasn't seen any update or feedback from
> > the original submitters since the original submission, so the entire HPLJ
> > code is a candidate for removal ...
> 
> Any idea precisely what model, and how to get it installed? 
> eBay calls... :)

They only ever published the initial code drop.  No code maintenance since
or any kind of documentation ...  However one of the group of code submitters
back then was claiming to run Gnome with remote X display - probably because
at least back then there was no support for the printing hw and anyway,
the refresh rate of a printer is somewhat limited ;-)

As I recall the code was originally submitted by roger_twede@hp.com.

  Ralf
