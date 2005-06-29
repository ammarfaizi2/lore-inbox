Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVF2Dzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVF2Dzb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 23:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262229AbVF2DzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 23:55:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13467 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262219AbVF2Dy3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 23:54:29 -0400
Date: Tue, 28 Jun 2005 23:52:48 -0400
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: Daniel Drake <dsd@gentoo.org>, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, sfudally@fau.edu
Subject: Re: [PATCH] amd64-agp: Add SIS760 PCI ID
Message-ID: <20050629035248.GA12820@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	Daniel Drake <dsd@gentoo.org>, davej@codemonkey.org.uk,
	linux-kernel@vger.kernel.org, sfudally@fau.edu
References: <42C1E5CA.6060507@gentoo.org> <20050629032403.GB21575@bragg.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050629032403.GB21575@bragg.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 05:24:03AM +0200, Andi Kleen wrote:
 > On Wed, Jun 29, 2005 at 01:05:30AM +0100, Daniel Drake wrote:
 > > From: Scott Fudally <sfudally@fau.edu>
 > > 
 > > This patch adds the SiS 760 ID to the amd64-agp driver, so that agpgart can be
 > > used on Athlon64 boards based on this chip.
 > 
 > You mean used automatically. You could always force it before.
 > 
 > > 
 > > Scott already submitted this but did not recieve any response. To ensure it
 > > has been sent in correctly, I am resubmitting this now on his behalf.
 > 
 > It's fine for me thanks. I assume Dave will queue it up.

Yep, Already sent to Linus.

thanks.

		Dave

