Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268556AbRG3MXx>; Mon, 30 Jul 2001 08:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268557AbRG3MXn>; Mon, 30 Jul 2001 08:23:43 -0400
Received: from SSH.ChaoticDreams.ORG ([64.162.95.164]:61317 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S268556AbRG3MX0>; Mon, 30 Jul 2001 08:23:26 -0400
Date: Mon, 30 Jul 2001 05:23:02 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: john slee <indigoid@higherplane.net>, linux-kernel@vger.kernel.org
Subject: Re: Test mail
Message-ID: <20010730052302.A17736@ChaoticDreams.ORG>
In-Reply-To: <20010730050749.A17726@ChaoticDreams.ORG> <E15RBxB-0003fv-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <E15RBxB-0003fv-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 30, 2001 at 01:15:21PM +0100
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 01:15:21PM +0100, Alan Cox wrote:
> > > ELM, Pine and Mutt have all at various times had holes that could have been
> > > used to write an exact Unix equivalent of the windows virus. 
> > > <img src="file:/dev/mouse"> hangs some web browser email 4 years after the
> > > bug was reported and so on...
> > > 
> > This all goes back to opening things blindly, and also ties in the issue of
> > HTML aware email clients.
> 
> Most exploits are header parsing flaws, HTML email is irrelevant to this
> discussion.
> 
Parsing an <img> tag certainly seems to make HTML email relevant...

> > Mail clients should simply be dealing with plain text. As soon as things like
> > HTML support are introduced into the client, you have the same sort of
> > problems that you do with easily exploitable web browsers.
> 
> No. Most of them are header parsing flaws, they worked with plain text
> email just fine. In fact HTML parsing vulnerabilities (other than privacy
> violations) are pretty rare.
> 
There are far fewer header parsing exploits floating around then there are
users executing things of an unknown origin and unknowingly sending copies of
said thing to everyone in their address book.

While header parsing exploits are indeed an issue, they hardly make up the
bulk of these sort of exploits.

Things like Elm, Pine, and Mutt can be as exploitable as anything else as far
as header parsing issues are concerned. They still account for far less
of the problems than things like Outlook do.

Regards,

-- 
Paul Mundt <lethal@chaoticdreams.org>

