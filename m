Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSF3L0Q>; Sun, 30 Jun 2002 07:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314835AbSF3L0P>; Sun, 30 Jun 2002 07:26:15 -0400
Received: from [62.70.58.70] ([62.70.58.70]:49797 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314829AbSF3L0O> convert rfc822-to-8bit;
	Sun, 30 Jun 2002 07:26:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Christer Weinigel <wingel@nano-system.com>
Subject: Re: Can't find watchdog timer (sc1200)
Date: Sun, 30 Jun 2002 13:28:23 +0200
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
References: <200206271803.11350.roy@karlsbakk.net> <m36601827v.fsf@acolyte.hack.org>
In-Reply-To: <m36601827v.fsf@acolyte.hack.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206301328.23850.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 June 2002 12:56, Christer Weinigel wrote:
> Roy Sigurd Karlsbakk <roy@karlsbakk.net> writes:
> > I can't make linux (2.4.19-rc1) detect the watchdog timer in the sc1200.
> > Any ideas?
>
> http://basselope.nano-system.com/~wingel/scx200_wdt.diff
>
> I'm not all that sure if that driver works on the sc1200 because that
> driver tries to talk to the watchdog in the SuperI/O chip and that
> chip has another watchdog circuit too.  I've written a driver for the
> other watchdog chip, so if you can, please try this patch against a
> 2.4.9-pre10 kernel:

I guess that'll be 2.4.19-pre10? :-)

Thanks, but I'll wait till I get new hardware. the Samsung STCs I were trying 
out were in early beta.

roy


-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

