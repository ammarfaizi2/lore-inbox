Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267877AbTAHUZH>; Wed, 8 Jan 2003 15:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTAHUZG>; Wed, 8 Jan 2003 15:25:06 -0500
Received: from [66.70.28.20] ([66.70.28.20]:47885 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267877AbTAHUZD>; Wed, 8 Jan 2003 15:25:03 -0500
Date: Wed, 8 Jan 2003 21:35:48 +0100
From: DervishD <raul@pleyades.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Killing off the boot sector (was: [STATUS 2.5]  January 8, 2002)
Message-ID: <20030108203548.GA6537@DervishD>
References: <3E1C2208.6727.5370CB@localhost> <avi06f$89g$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avi06f$89g$1@cesium.transmeta.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi HPA :))

> Can we *please* kill off the stupid in-kernel boot sector?

    Yespleaseyespleaseyesplease... I posted a message here a long
time ago because I couldn't boot a raw kernel image with 2.4.x. Well,
it didn't work even with a emulated floppy image (El Torito, you
know)...

    I think that, with those good boot loaders out there, this piece
of code, that is architecture dependend, should be off-the kernel.

    IMHO, those saved bytes should be used to store another cool Tux
image or something like that XDDDDD

> People keep asking what's the harm in keeping it, and the answer is,
> quite simply: "because people continue to try to use it."

    Exact...

    You've got a very good and sensible idea ;)
    Raúl
