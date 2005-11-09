Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVKIPVH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVKIPVH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 10:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVKIPVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 10:21:06 -0500
Received: from www.swissdisk.com ([216.144.233.50]:40932 "EHLO
	swissweb.swissdisk.com") by vger.kernel.org with ESMTP
	id S1751406AbVKIPVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 10:21:05 -0500
Date: Wed, 9 Nov 2005 06:09:52 -0800
From: Ben Collins <ben.collins@ubuntu.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Xavier Bestel <xavier.bestel@free.fr>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Drake <dsd@gentoo.org>, Ben Collins <bcollins@ubuntu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
Message-ID: <20051109140952.GA30611@swissdisk.com>
References: <20051106013752.GA13368@swissdisk.com> <436E17CA.3060803@gentoo.org> <1131316729.1212.58.camel@localhost.localdomain> <436F81D1.7000100@gentoo.org> <1131383311.11265.22.camel@localhost.localdomain> <1131383144.2477.9.camel@capoeira> <20051107173201.GF3847@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107173201.GF3847@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 06:32:01PM +0100, Adrian Bunk wrote:
> On Mon, Nov 07, 2005 at 06:05:44PM +0100, Xavier Bestel wrote:
> > On Mon, 2005-11-07 at 18:08, Alan Cox wrote:
> > > On Llu, 2005-11-07 at 16:33 +0000, Daniel Drake wrote:
> > > > Source RPM's will just contain a Linux kernel tree with your patches already 
> > > > applied, right?
> > > 
> > > Of course not. Its an rpm file. RPM files contain a set of broken out
> > > patches and base tar ball plus controlling rules for application. It's
> > > rather more advanced than .deb sources.
> > 
> > That's a troll, Alan. .deb contain exactely the same things.
> 
> No, he's right.

That's only right in the simplest form. However, the debian kernel and a
huge portion of other complex packages contain a debian/patches/ directory
that gets applied at build time. Each patch is broken out seperately, with
description embedded in the patch.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux
