Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263216AbTCSWUE>; Wed, 19 Mar 2003 17:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263227AbTCSWUE>; Wed, 19 Mar 2003 17:20:04 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:36362 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263216AbTCSWTP>;
	Wed, 19 Mar 2003 17:19:15 -0500
Date: Wed, 19 Mar 2003 14:17:59 -0800
From: Greg KH <greg@kroah.com>
To: Jason McMullan <jmcmullan@linuxcare.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HID Patch for Essential Reality P5 Glove
Message-ID: <20030319221759.GB16947@kroah.com>
References: <20030319182046.GA32527@client100.evillabs.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319182046.GA32527@client100.evillabs.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 01:20:46PM -0500, Jason McMullan wrote:
> 
>   This patch adds the Essential Reality P5 data glove to the HID
> blacklist. It's yet another device that advertises itself as a HID,
> and doesn't comply with the HID specs.

I don't seem to be able to apply this patch:
drivers/usb/hid-core.c 1.32: 1360 lines
patching file drivers/usb/hid-core.c
patch: **** malformed patch at line 23: @@ -1133,7 +1153,8 @@

Any thoughts?

Oh, and can you also send a 2.5 version of this?

thanks,

greg k-h
