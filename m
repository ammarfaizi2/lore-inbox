Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314340AbSF2WpC>; Sat, 29 Jun 2002 18:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314381AbSF2WpB>; Sat, 29 Jun 2002 18:45:01 -0400
Received: from go-gw.beelinegprs.com ([217.118.66.254]:31056 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S314340AbSF2WpA>; Sat, 29 Jun 2002 18:45:00 -0400
Date: Sun, 30 Jun 2002 02:45:10 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-rc1 broke OSF binaries on alpha
Message-ID: <20020630024510.A725@localhost.park.msu.ru>
References: <20020628145406.A17560@jurassic.park.msu.ru> <E17O7wJ-0007vj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E17O7wJ-0007vj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 29, 2002 at 03:26:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2002 at 03:26:18AM +0100, Alan Cox wrote:
> Please fix the Alpha port. The behaviour fixed is _required_ by SuS.

No objections, but
a) it wasn't a bugfix (just a compliance crap)
b) it seriously broke the alpha port right before the new
   kernel release.

> Make your own alpha syscall that handles this crap.

I'd be happy to see that patch included in 2.4.20-pre1.

Ivan.
