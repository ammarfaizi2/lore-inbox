Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266186AbUFPGw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266186AbUFPGw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 02:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266189AbUFPGw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 02:52:59 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:37636 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S266186AbUFPGw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 02:52:58 -0400
Subject: Re: [PATCH] Stairacse scheduler v6.E for 2.6.7-rc3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1087333441.40cf6441277b5@vds.kolivas.org>
References: <1087333441.40cf6441277b5@vds.kolivas.org>
Content-Type: text/plain
Date: Wed, 16 Jun 2004 08:38:47 +0200
Message-Id: <1087367927.1692.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.1 (1.5.9.1-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-06-16 at 07:04 +1000, Con Kolivas wrote:
> Here is an updated version of the staircase scheduler. I've been trying to hold
> off for 2.6.7 final but this has not been announced yet. Here is a brief update
> summary.

I'm currently testing this one. The problems I was having when trying to
suspend have gone away with this new release, so it looks promising to
me. Will keep you informed.

Thanks!

PS: I'm modifying your patch for 2.6.7-rc3-mm2. Could you please provide
newer versions of this patch against -mm kernels?

