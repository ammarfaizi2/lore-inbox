Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262333AbVBXMWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262333AbVBXMWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 07:22:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVBXMU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 07:20:29 -0500
Received: from mail1.kontent.de ([81.88.34.36]:55431 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262326AbVBXMR5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 07:17:57 -0500
From: Oliver Neukum <oliver@neukum.org>
To: "Alexander V. Lukyanov" <lav@netis.ru>
Subject: Re: [2.6.10] cdc-acm.c patches
Date: Thu, 24 Feb 2005 13:17:57 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050224120741.GA4639@night.netis.priv>
In-Reply-To: <20050224120741.GA4639@night.netis.priv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502241317.57686.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The problem was caused by patch in 2.6.8, which moved incrementing of
> acm->used to bottom of acm_tty_open. My patch to fix it is attached.

Your patch has been integrated into the USB tree which is  regularly
pushed up into the mainline.

	Regards
		Oliver
