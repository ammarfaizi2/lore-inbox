Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUFTWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUFTWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUFTWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:36:28 -0400
Received: from mail5-151.ewetel.de ([212.6.122.151]:53483 "EHLO
	mail5.ewetel.de") by vger.kernel.org with ESMTP id S265977AbUFTWgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:36:20 -0400
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild updates
In-Reply-To: <29iwc-4g7-27@gated-at.bofh.it>
References: <29hJN-3Jl-35@gated-at.bofh.it> <29icN-42R-13@gated-at.bofh.it> <29imu-4ad-31@gated-at.bofh.it> <29iwc-4g7-27@gated-at.bofh.it>
Date: Mon, 21 Jun 2004 00:36:12 +0200
Message-Id: <E1BcAv6-0005Lc-Ug@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004 00:00:12 +0200, you wrote in linux.kernel:

> ---
> build_2_6_module:
> 	@make -C /lib/modules/`uname -r`/build M=3D`PWD`
> ---
>
> will break with proposed patch ...

Huh? Sam wrote there will be a Makefile in the output directory.

-- 
Ciao,
Pascal
