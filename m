Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265314AbSJRV3w>; Fri, 18 Oct 2002 17:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbSJRV3w>; Fri, 18 Oct 2002 17:29:52 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45585 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265314AbSJRV3v>;
	Fri, 18 Oct 2002 17:29:51 -0400
Date: Fri, 18 Oct 2002 14:35:22 -0700
From: Greg KH <greg@kroah.com>
To: Wiktor Wodecki <wodecki@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patch for linux/usb.h
Message-ID: <20021018213521.GA10351@kroah.com>
References: <20021018212532.GE32609@net-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018212532.GE32609@net-m.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 11:25:32PM +0200, Wiktor Wodecki wrote:
> +} urb_t;
> -};

Heh, you're kidding me, right?

No, that's not "missing" it was taken out because it should have never
gotten there in the first place.

thanks,

greg k-h
