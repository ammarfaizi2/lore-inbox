Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261904AbVGZQuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbVGZQuo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 12:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVGZQua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 12:50:30 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30378 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261904AbVGZQtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 12:49:49 -0400
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
In-Reply-To: <42E65B34.9080700@pobox.com>
References: <20050726150837.GT3160@stusta.de>  <42E65B34.9080700@pobox.com>
Content-Type: text/plain
Date: Tue, 26 Jul 2005 12:49:46 -0400
Message-Id: <1122396587.18884.34.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 11:48 -0400, Jeff Garzik wrote:
> NAK for i810_audio:  ALSA doesn't have all the PCI IDs (which must be 
> verified -- you cannot just add the PCI IDs for some hardware)

Some of them might be in snd-hda-intel in addition to snd-intel8x0.

Lee

