Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310193AbSCABdC>; Thu, 28 Feb 2002 20:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293447AbSCABbP>; Thu, 28 Feb 2002 20:31:15 -0500
Received: from THUNK.ORG ([216.175.175.175]:48619 "EHLO thunk.org")
	by vger.kernel.org with ESMTP id <S293486AbSCAB2s>;
	Thu, 28 Feb 2002 20:28:48 -0500
Date: Thu, 28 Feb 2002 20:28:03 -0500
From: Theodore Tso <tytso@mit.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Dennis Jim <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
Message-ID: <20020228202803.A14374@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Dennis Jim <jdennis@snapserver.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva> <E16gaUh-0001bB-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E16gaUh-0001bB-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 01, 2002 at 12:01:51AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:01:51AM +0000, Alan Cox wrote:
> > 
> > Nope. I could well integrate lm_sensors in the future.
> 
> Please be careful. lm_sensors can destroy machines if configured wrongly.
> Thats something that needs tackling - and ironically ACPI may actually
> solve that problem

... as in instant death for any modern Thinkpad laptops, requiring a
trip back to the factory and a replacement of the motherboard...

*Please* don't integrate in lm_sensors without making sure the
thinkpad killing feature has been fixed.

						- Ted
