Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268897AbRG3PUt>; Mon, 30 Jul 2001 11:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268903AbRG3PUj>; Mon, 30 Jul 2001 11:20:39 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:65286 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id <S268897AbRG3PUb>; Mon, 30 Jul 2001 11:20:31 -0400
Date: Mon, 30 Jul 2001 16:19:25 +0100 (BST)
From: Steve Hill <steve@navaho.co.uk>
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: serial console and kernel 2.4
In-Reply-To: <20010730165453.A19255@pc8.lineo.fr>
Message-ID: <Pine.LNX.4.21.0107301559470.19764-100000@sorbus.navaho>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001, christophe barbé wrote:

> Is there something that I'm missing ? (something new with the kernel 2.4
> that is required for a serial console that was not required with the 2.2 ?)

I've just started using 2.4.6 on both a Cobalt Qube 3 and Raq 4R (which
use serial consoles), and they seem to be fine... although if the console
isn't plugged in then it causes all sorts of problems so I've hacked
around the kernel to allow the console to point at null...

I'm just about to upgrade to 2.4.8-pre2 if it all works...

-- 

- Steve Hill
System Administrator         Email: steve@navaho.co.uk
Navaho Technologies Ltd.       Tel: +44-870-7034015

        ... Alcohol and calculus don't mix - Don't drink and derive! ...


