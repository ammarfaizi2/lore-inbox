Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbUKQOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbUKQOel (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 09:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbUKQOel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 09:34:41 -0500
Received: from mail.convergence.de ([212.227.36.84]:45017 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262330AbUKQOek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 09:34:40 -0500
Date: Wed, 17 Nov 2004 15:38:29 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Alex Woods <linux-dvb@giblets.org>, linux-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] [2.6 patch] remove some unneeded #ifdefs from dvb/ttusb-dec/ttusb_dec.c (fwd)
Message-ID: <20041117143829.GA6084@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, Alex Woods <linux-dvb@giblets.org>,
	linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
References: <20041116011824.GD4946@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116011824.GD4946@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 02:18:24AM +0100, Adrian Bunk wrote:
> 
> The patch forwarded below still applies against 2.6.10-rc1-mm5.
> 
> Please apply.
...
> DVB_TTUSB_DEC selects CRC32, do the #ifdefs can be removed.

I've applied the patch to linuxtv.org CVS.


Thanks,
Johannes
