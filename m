Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262788AbTKPNPz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTKPNPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:15:54 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:17332 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262788AbTKPNPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:15:53 -0500
Date: Sun, 16 Nov 2003 14:15:50 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: Carrier detection for network interfaces
Message-ID: <20031116131550.GD7650@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <1068912989.5033.32.camel@nosferatu.lan> <3FB652BA.1010905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB652BA.1010905@pobox.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Nov 2003, Jeff Garzik wrote:

> What kernel version?
> 
> In 2.6 you have linkwatch.  In 2.4 and 2.6, you have ETHTOOL_GLINK, and 
> mii-tool.

Whatever linkwatch is (can't find it with Google and freshmeat quickly).

For 3c59x, neither mii-tool nor ethtool work with 2.6, only mii-diag
will do.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
