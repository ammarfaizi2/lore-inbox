Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132642AbRAFXaf>; Sat, 6 Jan 2001 18:30:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135271AbRAFXa1>; Sat, 6 Jan 2001 18:30:27 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:59922 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S132642AbRAFXaO>; Sat, 6 Jan 2001 18:30:14 -0500
Message-ID: <3A57AA73.AC90D9A2@easypenguin.co.uk>
Date: Sat, 06 Jan 2001 23:29:55 +0000
From: Jon Masters <jonathan@easypenguin.co.uk>
Organization: http://www.jonmasters.org.uk
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Mutz <Marc@Mutz.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Crypto in 2.4
In-Reply-To: <3A553A03.DCFBCB9@easypenguin.co.uk> <3A578F68.C4F4ADC7@Mutz.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Mutz wrote:

> A 2.4.0.1 should be on ftp.kernel.org/pub/linux/kernel/crypto/v2.4/.
> But it has been heavily re-worked. I haven't got my hands on that one
> and will keep quiet as to what extend that patch is produiction-ready,
> but I remember that the loop driver in 2.4.0 still can stall your box. 

Hmmm, it's magically appeared :P

As far as the stability goes, this is one of my current hang-ups - I've
heard about the loopback stuff in 2.4. I want to use 2.4 but I can't use
any of my systems without crypto (and hence loopback) since key personal
data is stored therein and I don't want to sacrifice stability.

> Since the kerneli crypto relies on loop, this would count in favor of
> "don't do that yet".

Indeed. I wish I could help improve things - I'm not really in the game
yet although I want to be and I am working towards that.

> BTW: You might want to join linux-crypto@nl.linux.org (majordomo) if
> you are interested in kerneli.

Indeed I am interested - I've been using it for quite some time - I
really don't know why I overlooked that list.

jcm mails majordomo...

Jonathan.

-- 
 ________oooo_________ jonathan@jonmasters.org.uk _________oooo________
| Technical, Easy Penguin.  +44 777 61 31337       GPG keys available. |
|"And am I, who lived but for my country"         [quote: Robert Emmet]|
 --------oooo-------- http://www.jonmasters.org.uk --------oooo--------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
