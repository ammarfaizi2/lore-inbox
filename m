Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVBPIf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVBPIf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 03:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVBPIf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 03:35:26 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:2790 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261912AbVBPIfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 03:35:22 -0500
Date: Wed, 16 Feb 2005 09:35:49 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: InputML <linux-input@atrey.karlin.mff.cuni.cz>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RCF/RFT] Fix race timer race in gameport-based joystick drivers
Message-ID: <20050216083549.GD1535@ucw.cz>
References: <200502150042.32564.dtor_core@ameritech.net> <d120d500050215065115706773@mail.gmail.com> <20050215150606.GA8560@ucw.cz> <200502160046.00311.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502160046.00311.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 12:45:59AM -0500, Dmitry Torokhov wrote:
> Somehow missed sidewinder driver...
> 
> ======================================================================
> 
> Input: fix timer handling race in sidewinder joystick driver by
>        switching to gameport's polling facilities.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Thanks; applied.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
