Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S262279AbUKDSN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUKDSN1 (ORCPT <rfc822;akpm@zip.com.au>);
	Thu, 4 Nov 2004 13:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262334AbUKDSKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:10:19 -0500
Received: from hentges.net ([81.169.178.128]:18873 "EHLO
	h6563.serverkompetenz.net") by vger.kernel.org with ESMTP
	id S262279AbUKDSFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:05:32 -0500
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
From: Matthias Hentges <mailinglisten@hentges.net>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <418A1D51.4010504@free.fr>
References: <418A1D51.4010504@free.fr>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 19:05:28 +0100
Message-Id: <1099591528.3643.1.camel@mhcln03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello matthieu,

Am Donnerstag, den 04.11.2004, 13:15 +0100 schrieb matthieu castet:

[...]

> Could you try these 2 patchs with CONFIG_PNPACPI=y ?

Yes, those two patches fix the keyboard for me with CONFIG_PNPACPI=y.
Thanks!

-- 
Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian SID. Geek by Nature, Linux by Choice

