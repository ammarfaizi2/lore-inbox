Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267739AbUJLU0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267739AbUJLU0q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267745AbUJLU0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:26:46 -0400
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:3518 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S267739AbUJLU0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:26:43 -0400
Date: Tue, 12 Oct 2004 15:24:04 -0500
From: Andy Warner <andyw@pobox.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tom Dickson <tdickson@inostor.com>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andy Warner <andyw@pobox.com>
Subject: Re: Who is working on the Marvell SATA Chipset?
Message-ID: <20041012152404.A14245@florence.linkmargin.com>
References: <416C2BD6.10802@inostor.com> <416C3378.6000001@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <416C3378.6000001@pobox.com>; from jgarzik@pobox.com on Tue, Oct 12, 2004 at 03:41:44PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Tom Dickson wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> > 
> > Who is in charge of the "in progress" driver for the Marvell 88SX5040?
> 
> I have a skeleton driver locally, need to get on to finishing it.

Marvell also have drivers for 2.4 and 2.6, but they are under NDA
etc etc, and ignore libata (they also pre-date libata), so if
you have hardware that you _must_ get working; they might be
a useful stopgap.

I'll repeat my eagerness to test anything for the 88SX50xx or 88SX60xx,
regardless of how primitive it is. My benchmarking with the Marvell
driver shows the throughput to be excellent.
-- 
andyw@pobox.com

Andy Warner		Voice: (612) 801-8549	Fax: (208) 575-5634
