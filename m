Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVD3SV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVD3SV0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 14:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVD3SVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 14:21:25 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:17413 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261330AbVD3SVV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 14:21:21 -0400
Date: Sat, 30 Apr 2005 20:21:20 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, sailer@ife.ee.ethz.ch,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: [2.6 patch] drivers/net/hamradio/baycom_epp.c: cleanups
Message-ID: <20050430182120.GB41358@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	sailer@ife.ee.ethz.ch, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, netdev@oss.sgi.com
References: <20050430181529.GF3571@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050430181529.GF3571@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2005 at 08:15:30PM +0200, Adrian Bunk wrote:
> The times when tricky goto's produced better codes are long gone.
> 
> This patch should express the same in a better way, please check whether 
> I made any mistake.

Stupid question I'm sure, but did you bench it?

  OG.
