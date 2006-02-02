Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422938AbWBBFT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422938AbWBBFT0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 00:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422939AbWBBFTZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 00:19:25 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:7841 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422938AbWBBFTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 00:19:25 -0500
Subject: Re: [PATCH] PCI: restore 2 missing pci ids
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Rustad <mrustad@mac.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <A9543B03-333E-470F-AD18-0313192ADB23@mac.com>
References: <200602010609.k1169QDX017012@hera.kernel.org>
	 <43E0F73B.6040507@pobox.com> <A9543B03-333E-470F-AD18-0313192ADB23@mac.com>
Content-Type: text/plain
Date: Thu, 02 Feb 2006 00:19:19 -0500
Message-Id: <1138857560.15691.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-01 at 23:11 -0600, Mark Rustad wrote:
> Why were the ids  
> removed in the first place? 

Because they weren't used by anything in the tree.

Lee

