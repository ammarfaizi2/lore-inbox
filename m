Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbVKKNZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVKKNZK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbVKKNZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 08:25:09 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49107 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750732AbVKKNZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 08:25:08 -0500
Date: Thu, 10 Nov 2005 15:09:59 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] move pm_register/etc. to CONFIG_PM_LEGACY, pm_legacy.h
Message-ID: <20051110150958.GA1910@spitz.ucw.cz>
References: <20051107091313.GA15128@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107091313.GA15128@havoc.gtf.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since few people need the support anymore, this moves the legacy
> pm_xxx functions to CONFIG_PM_LEGACY, and include/linux/pm_legacy.h.

Yes, very nice!

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

