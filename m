Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267419AbVBEOI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267419AbVBEOI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267417AbVBEOI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:08:57 -0500
Received: from mail1.kontent.de ([81.88.34.36]:56512 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S273566AbVBEOIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:08:34 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] remove drivers/char/tpqic02.c
Date: Sat, 5 Feb 2005 15:08:18 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050205114047.GA3129@stusta.de>
In-Reply-To: <20050205114047.GA3129@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051508.18813.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 5. Februar 2005 12:40 schrieb Adrian Bunk:
> Since at about half a year, this driver was no longer selectable via
> Kconfig.

What happened when you ran oldconfig with a .config that had it set?

	Regards
		Oliver
