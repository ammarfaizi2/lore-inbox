Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289299AbSB0VQU>; Wed, 27 Feb 2002 16:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292956AbSB0VPu>; Wed, 27 Feb 2002 16:15:50 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:16261 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S292860AbSB0VPh>; Wed, 27 Feb 2002 16:15:37 -0500
Date: Wed, 27 Feb 2002 16:15:19 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Andreas Dilger <adilger@turbolabs.com>,
        "Dennis, Jim" <jdennis@snapserver.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: crypto (was Re: Congrats Marcelo,)
Message-ID: <20020227161519.A13912@alcove.wittsend.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Andreas Dilger <adilger@turbolabs.com>,
	"Dennis, Jim" <jdennis@snapserver.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C7BFAFA.D8923CFF@mandrakesoft.com> <Pine.LNX.4.33L.0202261932580.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0202261932580.7820-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 07:33:50PM -0300, Rik van Riel wrote:
> On Tue, 26 Feb 2002, Jeff Garzik wrote:

> > IMO it's time to get a good IPsec implementation in the kernel...

> Where would we get one of those ?

> The freeswan folks seem quite determined to not let any
> americans touch their code, so inclusion of their stuff
> into the kernel is out.

	No...  That's patently not true.

	They won't accept contributions from us, but we touch
their code all the time.  If we didn't, how would we get any testing
done, which they do accept from us.

	Also, several of them have stated on several occasions (this is
the prerequisite religious war that pops up every few months) that
they have no say in what other people do with the code (subject to the
license of course) and that inclusion of klips in the mainline kernel
would be beyond their control, yeah or nay.  Klips is the ONLY part
of freeswan that would go in the kernel.  Pluto (IKE) is the user
space part.

	They won't accept contributions from US developers to their code
base.  That does NOT mean that they will not accept contributing the IPSec
kernel code to the kernel and the incorporation of klips into the kernel
source tree.

> Do you know of a nice ipsec implementation we could use?

	Yes.  FreeSWAN.  And the FreeSWAN developers have as much as said so.

> Rik
> -- 
> "Linux holds advantages over the single-vendor commercial OS"
>     -- Microsoft's "Competing with Linux" document
> 
> http://www.surriel.com/		http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
