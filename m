Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262806AbVCPVW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262806AbVCPVW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262808AbVCPVWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:22:55 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:17537 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262806AbVCPVW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:22:29 -0500
Date: Wed, 16 Mar 2005 22:22:16 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Message-ID: <20050316212216.GB4526@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@sig21.net>,
	Mikael Pettersson <mikpe@user.it.uu.se>,
	linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
References: <16950.59948.810534.979691@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16950.59948.810534.979691@alkaid.it.uu.se>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: 217.231.51.130
Subject: Re: [PATCH][2.6.11] drivers/media/dvb/bt8xx/bt878.h gcc4 fix
X-SA-Exim-Version: 4.2 (built Tue, 25 Jan 2005 19:36:50 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 02:59:08PM +0100, Mikael Pettersson wrote:
> Fix one array-of-incomplete-type error from gcc4 in bt878.h.

Applied to linuxtv.org CVS.

Thanks,
Johannes
