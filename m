Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281492AbRKPTJ3>; Fri, 16 Nov 2001 14:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281489AbRKPTJU>; Fri, 16 Nov 2001 14:09:20 -0500
Received: from demai05.mw.mediaone.net ([24.131.1.56]:54959 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S281488AbRKPTJH>; Fri, 16 Nov 2001 14:09:07 -0500
Message-Id: <200111161907.fAGJ7XE12507@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: <lk@Aniela.EU.ORG>, <linux-kernel@vger.kernel.org>
Subject: Re: what hardware for AMD processors ?
Date: Fri, 16 Nov 2001 14:07:22 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0111162002560.785-100000@ns1.Aniela.EU.ORG>
In-Reply-To: <Pine.LNX.4.33.0111162002560.785-100000@ns1.Aniela.EU.ORG>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For SMP, your only options at the moment are the two Tyan boards.  We had 
some issues with them on multiple small (256MB) memory modules, but they 
have been kind to us since we moved to 512MB modules.  Obviously, they 
have only been out a few months, so long-term stability is still up in the 
air.

The latest revision we received can boot headless (no video card) off a 
serial port.  Linux, of course, can run console off serial, too.

We haven't had a hint of trouble with the Gigabyte GA-7DX, but we haven't 
pushed it past 1.2 GHz and 512MB.  YMMV, especially since a couple people 
here mentioned issues with large capacity memory modules.  The AMD 761's 
AGP support is also as fragile as glass -- not that it sounds like you'll 
use it.

	-- Brian

On Friday 16 November 2001 01:06 pm, lk@Aniela.EU.ORG wrote:
> Hi,
>
> 	I have a question about AMD AthlonXP and AthlonMP:
> What motherboards do you recomend for building an Atlon based network
> server that will run 24/7 365days a year under high loads ? I need a
> rock solid motherboard that can support at least 2GB of RAM, and
> optionally integrated video card onboard.
