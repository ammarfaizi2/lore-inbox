Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263194AbVGODHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263194AbVGODHN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263187AbVGODFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:05:22 -0400
Received: from mail.suse.de ([195.135.220.2]:732 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S263185AbVGODFT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:05:19 -0400
Date: Fri, 15 Jul 2005 05:05:18 +0200
From: Andi Kleen <ak@suse.de>
To: yhlu <yinghailu@gmail.com>
Cc: Andi Kleen <ak@suse.de>, "Ronald G. Minnich" <rminnich@lanl.gov>,
       Stefan Reinauer <stepan@openbios.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: NUMA support for dual core Opteron
Message-ID: <20050715030518.GS23737@wotan.suse.de>
References: <2ea3fae10507141058c476927@mail.gmail.com> <Pine.LNX.4.58.0507141259170.22630@enigma.lanl.gov> <20050714190929.GL23619@wotan.suse.de> <2ea3fae1050714194649c66d7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ea3fae1050714194649c66d7e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 07:46:49PM -0700, yhlu wrote:
> p.s. can you use powernow when acpi is disabled?

Only on uniprocessor machines.

> p.s.s  Is powerpc64 support ACPI? or ACPI is only can be used by x86?

powerpc64 uses openfirmware, not ACPI.

-Andi
