Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280426AbRKSRjO>; Mon, 19 Nov 2001 12:39:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRKSRjG>; Mon, 19 Nov 2001 12:39:06 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:51469 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S280426AbRKSRis>; Mon, 19 Nov 2001 12:38:48 -0500
Date: Mon, 19 Nov 2001 18:38:42 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "S. Zimmermann" <sz@bigfoot.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i2o and Promise SuperTrak SX6000 ata raid controller
Message-ID: <20011119183842.A19280@suse.cz>
In-Reply-To: <3BF9236F.5070206@bigfoot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF9236F.5070206@bigfoot.com>; from sz@bigfoot.com on Mon, Nov 19, 2001 at 04:21:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 04:21:19PM +0100, S. Zimmermann wrote:
> Hello,
> 
> I tried to use a Promise SuperTrak SX6000 with kernel 2.4.14 or 
> 2.4.13-ac8. In both cases the i2o driver doesn't detect the controller 
> at all. According to Promise the controller is supposed to be supported 
> by current kernels. Any idea?

Easy: Switch the controller mode (in BIOS) to "Other OS", not "Linux".
It doesn't work with the "Linux" setting ...

-- 
Vojtech Pavlik
SuSE Labs
