Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWGaPv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWGaPv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 11:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWGaPv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 11:51:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:8426 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750902AbWGaPv5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 11:51:57 -0400
Date: Mon, 31 Jul 2006 17:51:45 +0200
From: Olaf Hering <olh@suse.de>
To: Edgar Hucek <hostmaster@ed-soft.at>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       akpm@osdl.org
Subject: Re: [PATCH 1/3] add-imacfb-docu-and-detection.patch
Message-ID: <20060731155145.GA3431@suse.de>
References: <44CDBE5D.8020504@ed-soft.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <44CDBE5D.8020504@ed-soft.at>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Jul 31, Edgar Hucek wrote:

> This Patch add basic Machine detection to imacfb and
> some Ducumentation bits for imacfb.

> +Supported Hardware
> +==================
> +
> +iMac 17"/20"
> +Macbook
> +Macbook Pro 15"/17"
> +MacMini

Why is it called imacfb when it is supposed to drive castrated PowerBooks?
I suggest a better name for driver.
