Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263514AbVBEGUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263514AbVBEGUy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 01:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263030AbVBEGUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 01:20:53 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:27599 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S263811AbVBEGUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 01:20:46 -0500
Date: Sat, 5 Feb 2005 07:21:06 +0100
From: Vojtech Pavlik <vojtech@ucw.cz>
To: dtor_core@ameritech.net
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] input: make some code static
Message-ID: <20050205062106.GA2344@ucw.cz>
References: <20050204213955.GE19408@stusta.de> <d120d50005020413563d031866@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d50005020413563d031866@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2005 at 04:56:45PM -0500, Dmitry Torokhov wrote:
> On Fri, 4 Feb 2005 22:39:55 +0100, Adrian Bunk <bunk@stusta.de> wrote:
> > This patch makes some needlessly global code static.
> > 
> 
> Hi Adrian,
> 
> I merged your patch into my tree and it is ready for Vojtech to pull from.
 
Dmitry, I already pulled. :) Btw, please use my vojtech@ucw.cz (or
@suse.de) e-mail addresses during the weekend, as mu @suse.cz doesn't
work and likely won't be fixed until Monday.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
