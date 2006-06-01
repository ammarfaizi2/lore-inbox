Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWFBMVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWFBMVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWFBMVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:21:51 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42985 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751233AbWFBMVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:21:50 -0400
Subject: Re: [aacraid] Is that a linux issue or flaky hardware?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Olivier Galibert <galibert@pobox.com>
Cc: "Hack inc." <linux-kernel@vger.kernel.org>
In-Reply-To: <20060601181155.GA95280@dspnet.fr.eu.org>
References: <20060601181155.GA95280@dspnet.fr.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 01 Jun 2006 22:44:36 +0100
Message-Id: <1149198277.18267.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-06-01 at 20:11 +0200, Olivier Galibert wrote:
> I have a new dual-EMT64 server with an aacraid skyhawk (asr-2020s
> pci-x zcr) in it and the drives supposedly in raid1.  The aacraid dies
> shortly after I start using it, with both an up-to-date FC5 kernel and
> a gentoo installcd 2006.0.
> 
> Are there known issues with that hardware under linux, or is that an
> hardware issue?

Not that I am aware of with the reported hardware, and your system seems
to have just croaked. Does the same occur if you boot with 2GB or less
memory limit ?

Also please cc the maintainer of the driver, he's rather good and
usually responsive.

