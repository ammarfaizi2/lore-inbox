Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUIMXRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUIMXRO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 19:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269045AbUIMXRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 19:17:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:2945 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269022AbUIMXRN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 19:17:13 -0400
Date: Tue, 14 Sep 2004 01:16:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Yuval Turgeman <yuvalt@gmail.com>
cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Menuconfig search changes - pt. 3
In-Reply-To: <9ae345c0040904101365a1ca63@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0409140111100.877@scrub.home>
References: <20040903190023.GA8898@aduva.com>  <Pine.LNX.4.61.0409040152160.877@scrub.home>
 <9ae345c0040904101365a1ca63@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 4 Sep 2004, Yuval Turgeman wrote:

> > Please send a complete patch, it makes commenting on it easier.
> 
> Ok, will do.

Could you please resend one complete (logical) patch.
Something I'd really like to see before merging this (besides other small 
fixes) is separating the search into a function, which returns the result 
in a NULL terminated, allocated array.

bye, Roman
