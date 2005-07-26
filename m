Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbVGZPp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVGZPp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 11:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVGZPp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 11:45:29 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:1428 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261682AbVGZPpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 11:45:25 -0400
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
From: Thomas Sailer <t.sailer@alumni.ethz.ch>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, perex@suse.cz, alsa-devel@alsa-project.org,
       James@superbug.demon.co.uk, sailer@ife.ee.ethz.ch,
       linux-sound@vger.kernel.org, zab@zabbo.net, kyle@parisc-linux.org,
       parisc-linux@lists.parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com
In-Reply-To: <20050726150837.GT3160@stusta.de>
References: <20050726150837.GT3160@stusta.de>
Content-Type: text/plain
Organization: e-vision, inc.
Date: Tue, 26 Jul 2005 17:41:52 +0200
Message-Id: <1122392512.5240.47.camel@playstation2.hb9jnx.ampr.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 32701; Body=14
	Fuz1=14 Fuz2=14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-26 at 17:08 +0200, Adrian Bunk wrote:
> This patch schedules obsolete OSS drivers (with ALSA drivers that 
> support the same hardware) for removal.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
Acked-by: Thomas Sailer <sailer@ife.ee.ethz.ch>


