Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422898AbWBOGxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422898AbWBOGxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 01:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422899AbWBOGxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 01:53:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28833 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422898AbWBOGxD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 01:53:03 -0500
Date: Tue, 14 Feb 2006 22:51:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060214225154.2e82dfd2.akpm@osdl.org>
In-Reply-To: <m2zmkuqcs5.fsf@vador.mandriva.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<20060212190520.244fcaec.akpm@osdl.org>
	<s5hk6bz4gca.wl%tiwai@suse.de>
	<m2zmkuqcs5.fsf@vador.mandriva.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thierry Vignaud <tvignaud@mandriva.com> wrote:
>
> Takashi Iwai <tiwai@suse.de> writes:
> 
>  > It's not a "regression".  PM didn't work with ens1370 at all in the
>  > eralier version.
> 
>  btw, PM support in snd-intel8x0 is broken (at least regarding
>  suspending) in 2.6.16-rc2-mm1 on a nforce2 chipset

Can you identify when this breakage occurred?
