Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129607AbRAaLHs>; Wed, 31 Jan 2001 06:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129780AbRAaLHi>; Wed, 31 Jan 2001 06:07:38 -0500
Received: from d14144.upc-d.chello.nl ([213.46.14.144]:38628 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S129607AbRAaLHY>;
	Wed, 31 Jan 2001 06:07:24 -0500
Date: Wed, 31 Jan 2001 12:07:12 +0100
From: Arjan van de Ven <arjan@fenrus.demon.nl>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1 -- Unresolved symbols in radio-miropcm20.o
Message-ID: <20010131120712.A11819@fenrus.demon.nl>
In-Reply-To: <3A772D3C.CB62DD4F@megapath.net> <m14NsuB-000OZJC@amadeus.home.nl> <20010131045520.B32636@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010131045520.B32636@cadcamlab.org>; from peter@cadcamlab.org on Wed, Jan 31, 2001 at 04:55:20AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2001 at 04:55:20AM -0600, Peter Samuelson wrote:
> 
> [Arjan van de Ven]
> > Unfortionatly, this is impossible. The miropcm config question is
> > asked before the "sound" question, and the aci question is asked
> > after that (all in ake config).
> 
> "Impossible" is perhaps a poor choice of terms.  "Awkward" and "ugly"
> are, however, quite descriptive. (:

This doesn't take into account the case where someone says "n" to
CONFIG_SOUND.

Greetings,
   Arjan van de Ven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
