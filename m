Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263428AbRFXAGL>; Sat, 23 Jun 2001 20:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbRFXAFw>; Sat, 23 Jun 2001 20:05:52 -0400
Received: from t2.redhat.com ([199.183.24.243]:51698 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263428AbRFXAFv>; Sat, 23 Jun 2001 20:05:51 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <0106221013280M.00692@localhost.localdomain> 
In-Reply-To: <0106221013280M.00692@localhost.localdomain>  <20010621160309.A6744@thyrsus.com> <20010622094934.A13075@thyrsus.com> <9gvj2g$khc$1@picard.cistron.nl> 
To: landley@webofficenow.com
Cc: wichert@cistron.nl (Wichert Akkerman), linux-kernel@vger.kernel.org
Subject: Re: Missing help entries in 2.4.6pre5 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 24 Jun 2001 01:05:45 +0100
Message-ID: <31580.993341145@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


landley@webofficenow.com said:
>  There's a really simple solution to that.  Eric can just make up his
> own help  file entries that are wildly inaccurate and actively
> insulting to whoever it  is who owns the symbol. 

Heh. Lets not be too harsh though. Chasing people who add config options
without help text is a thankless task for the most part, but I'm grateful to
ESR for doing it. I must admit I was actually counting on him to catch the
ones I'd missed.

It was only when he ignored my patch which removed an offending symbol and
explained the status of a couple of false positives, and kept asking about
them instead of placing them on his 'ignore' list that it became irritating.

I objected, he assures me they're on the ignore list now, and we're all 
happy.

--
dwmw2


