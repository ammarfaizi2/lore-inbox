Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbWF1Hhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWF1Hhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932753AbWF1Hhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:37:37 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:7604 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932761AbWF1Hhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:37:36 -0400
Date: Wed, 28 Jun 2006 09:37:33 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: Re: [klibc 07/31] i386 support for klibc
In-Reply-To: <klibc.200606272217.07@tazenda.hos.anvin.org>
Message-ID: <Pine.LNX.4.61.0606280937150.29068@yvahk01.tjqt.qr>
References: <klibc.200606272217.00@tazenda.hos.anvin.org>
 <klibc.200606272217.07@tazenda.hos.anvin.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> usr/klibc/arch/i386/libgcc/__ashldi3.S   |   29 +++++++
> usr/klibc/arch/i386/libgcc/__ashrdi3.S   |   29 +++++++
> usr/klibc/arch/i386/libgcc/__lshrdi3.S   |   29 +++++++
> usr/klibc/arch/i386/libgcc/__muldi3.S    |   34 ++++++++
> usr/klibc/arch/i386/libgcc/__negdi2.S    |   21 +++++

No divdi3?



Jan Engelhardt
-- 
