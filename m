Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265423AbTLSCVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 21:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265424AbTLSCVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 21:21:47 -0500
Received: from pc.200.110.8.250.millicomperu.com.pe ([200.110.8.250]:40665
	"EHLO mail.claridad.edu.pe") by vger.kernel.org with ESMTP
	id S265423AbTLSCVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 21:21:44 -0500
Message-ID: <3FE260B2.4060104@claridad.edu.pe>
Date: Thu, 18 Dec 2003 21:21:38 -0500
From: Sergio Aguayo <webmaster@claridad.edu.pe>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031218 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Lockup with 2.6.0
References: <20031219013810.20470.qmail@web40610.mail.yahoo.com>
In-Reply-To: <20031219013810.20470.qmail@web40610.mail.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had the same problem under 2.4.x (from 9 to 23). The problem was my 
old TNT2 (even when using VESA framebuffer), which was a little bit 
damaged.

Sergio Aguayo

szonyi calin wrote:

>Hi
>Bad news (with 2.6.0)
>
>I was writing a cd (with ide-atapi) and downloading something 
>on dial-up and when i switched desks (screens) in fvwm a 
>hard lockup occured (X froze, dial up link froze (the leds on
> the modem didn't blinked anymore) and i could't use alt + SysRQ
>also). I had to press the reset button :-(
>
>kernel config, dmesg and program versions attached
>
>Bye
>Calin
>
>=====
>--
>A mouse is a device used to point at 
>the xterm you want to type in.
>Kim Alm on a.s.r.
>
>_________________________________________________________________
>Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
>Yahoo! Mail : http://fr.mail.yahoo.com
>

