Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314498AbSD1Utr>; Sun, 28 Apr 2002 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSD1Uto>; Sun, 28 Apr 2002 16:49:44 -0400
Received: from smtp1.wanadoo.nl ([194.134.35.136]:44203 "EHLO smtp1.wanadoo.nl")
	by vger.kernel.org with ESMTP id <S314498AbSD1Utf>;
	Sun, 28 Apr 2002 16:49:35 -0400
Message-Id: <200204282049.g3SKnQ005127@smtp1.wanadoo.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: Alexander Hoogerhuis <alexh@ihatent.com>
Subject: Re: Linux 2.5.10-dj1
Date: Sun, 28 Apr 2002 22:49:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Dave Jones <davej@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20020427030823.GA21608@suse.de> <200204281145.g3SBjJJ20178@smtp2.wanadoo.nl> <m3lmb7zjkp.fsf@lapper.ihatent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 28 April 2002 21:53, Alexander Hoogerhuis wrote:
> I have an Compaq Armada M700, same problem. No ACPI configured,
> symtoms vary a bit from kernel to kernel, but generally either
> keyboard is totally dead, or it starts to get utterly confused about
> caps lock and shift.
>
> On 2.5.10-dj1 it works like this: keyboard led is responsive to
> hitting caps lock, but when LED is off I get upper case letter typed,
> and when LED is off I get lower case letters. However, the strange bit
> is that lets say I type in my username and password so that they
> appear in lowercase on the screen, I still don't get in. And just fir
> having tried, typing with the caps lock LED off, thus getting upper
> case text, doesn't help either.

I never saw this, but sometimes the keyboard is totally dead, and sometimes 
it is dead on startup but after about an hour it is working...

And for the mouse (a Logitech Optical Wheelmouse or a Fujitsu-Siemens 
wheelmouse) the scrollwheel does not work (it does for 2.4.x)

	Rudmer
