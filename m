Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTKVPri (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 10:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTKVPri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 10:47:38 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:25102 "EHLO w.ods.org")
	by vger.kernel.org with ESMTP id S262331AbTKVPrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 10:47:37 -0500
Date: Sat, 22 Nov 2003 16:47:20 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Marcelo Tosatti <marcelo@cyclades.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@Stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.4] Trivial changes to I2C stuff
Message-ID: <20031122154720.GA18110@alpha.home.local>
References: <20031122161510.7d5b4d20.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031122161510.7d5b4d20.khali@linux-fr.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

On Sat, Nov 22, 2003 at 04:15:10PM +0100, Jean Delvare wrote:
> The changes are only white space and comment changes, and line reordering.

<...>

> @@ -199,7 +199,7 @@
>  #define I2C_HW_SMBUS_AMD756	0x05
>  #define I2C_HW_SMBUS_SIS5595	0x06
>  #define I2C_HW_SMBUS_ALI1535	0x07
> -#define I2C_HW_SMBUS_W9968CF	0x08
> +#define I2C_HW_SMBUS_W9968CF	0x0d

Is this one intentionnal or just a typo ?

Cheers,
Willy

