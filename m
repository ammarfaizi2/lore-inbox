Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268487AbUIPQzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268487AbUIPQzJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268368AbUIPQrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:47:48 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:28356 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268453AbUIPQqD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 12:46:03 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm1
Date: Thu, 16 Sep 2004 13:45:55 -0300
User-Agent: KMail/1.7
References: <20040916024020.0c88586d.akpm@osdl.org>
In-Reply-To: <20040916024020.0c88586d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161345.56131.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +tune-vmalloc-size.patch

This one of course breaks nvidia's binary driver; so nvidia users should do a 
"patch -Rp1" to revert it.

Regards,
Norberto

