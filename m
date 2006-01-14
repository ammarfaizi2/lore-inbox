Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWANRpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWANRpG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 12:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbWANRpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 12:45:05 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:50393 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750720AbWANRpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 12:45:04 -0500
Date: Sat, 14 Jan 2006 18:44:53 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org,
       Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Subject: Re: [2.6 patch] SOFTWARE_SUSPEND: fix a typo in the dependencies
Message-ID: <20060114174453.GB16427@elf.ucw.cz>
References: <20060110043627.GD3911@stusta.de> <20060106202948.GB2736@ucw.cz> <20060114023515.GJ29663@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060114023515.GJ29663@stusta.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On So 14-01-06 03:35:15, Adrian Bunk wrote:
> This patch fixes a typo in the dependencies of SOFTWARE_SUSPEND.
> 
> This patch is based on a report by
> Jean-Luc Leger <reiga@dspnet.fr.eu.org>.

Applied to my tree, but feel free to push it yourself. It will take me
a while to sync.
								Pavel

-- 
Thanks, Sharp!
