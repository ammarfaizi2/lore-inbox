Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261928AbVGZQGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVGZQGF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVGZQEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:04:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50337 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261920AbVGZQC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:02:59 -0400
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
In-Reply-To: <42E65D50.3040808@pobox.com>
References: <20050726150837.GT3160@stusta.de>
	 <1122393073.18884.29.camel@mindpipe>  <42E65D50.3040808@pobox.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 12:02:56 -0400
Message-Id: <1122393777.18884.32.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 11:57 -0400, Jeff Garzik wrote:
> Lee Revell wrote:
> > On Tue, 2005-07-26 at 17:08 +0200, Adrian Bunk wrote:
> > 
> >>This patch schedules obsolete OSS drivers (with ALSA drivers that 
> >>support the same hardware) for removal.
> > 
> > 
> > How many non-obsolete OSS drivers were there?
> 
> someone needs to test the remaining PCI ID(s) that are in i810_audio but 
> not ALSA.
> 

Good luck finding someone with all that old hardware...

Lee

