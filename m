Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUI2Nxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUI2Nxy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUI2NxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:53:12 -0400
Received: from mproxy.gmail.com ([216.239.56.248]:59097 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268455AbUI2NtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:49:09 -0400
Message-ID: <21d7e9970409290649520a882c@mail.gmail.com>
Date: Wed, 29 Sep 2004 23:49:09 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Borislav Petkov <petkov@uni-muenster.de>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200409291517.58750.petkov@uni-muenster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040929102840.GA11325@none>
	 <21d7e99704092905284f48af35@mail.gmail.com>
	 <200409291517.58750.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> do you mean the CONFIG_AGP_INTEL option? Because my chipset is ICH4 and the
> help text for that option doesn't mention support for ICH4 chipsets.

you have an i845 GMCH, so you need intel AGP support, the ICH4 is the
other chip if I remember my Intel chipsets correctly...

Dave.
