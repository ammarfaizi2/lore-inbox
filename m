Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268543AbRG3MIx>; Mon, 30 Jul 2001 08:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbRG3MIn>; Mon, 30 Jul 2001 08:08:43 -0400
Received: from SSH.ChaoticDreams.ORG ([64.162.95.164]:53893 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S268543AbRG3MIa>; Mon, 30 Jul 2001 08:08:30 -0400
Date: Mon, 30 Jul 2001 05:07:49 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: john slee <indigoid@higherplane.net>, linux-kernel@vger.kernel.org
Subject: Re: Test mail
Message-ID: <20010730050749.A17726@ChaoticDreams.ORG>
In-Reply-To: <20010730214522.C1183@higherplane.net> <E15RBV4-0003d0-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.13i
In-Reply-To: <E15RBV4-0003d0-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jul 30, 2001 at 12:46:18PM +0100
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, Jul 30, 2001 at 12:46:18PM +0100, Alan Cox wrote:
> Its more than that. Its the same smug arrogance that is going to get a lot
> of people nasty shocks one day
> 
> ELM, Pine and Mutt have all at various times had holes that could have been
> used to write an exact Unix equivalent of the windows virus. 
> <img src="file:/dev/mouse"> hangs some web browser email 4 years after the
> bug was reported and so on...
> 
This all goes back to opening things blindly, and also ties in the issue of
HTML aware email clients.

Mail clients should simply be dealing with plain text. As soon as things like
HTML support are introduced into the client, you have the same sort of
problems that you do with easily exploitable web browsers.

These things are only an issue when your mail client tries to do things for
you instead of allowing you to do them yourself. HTML emails can simply be
fed through something like a lynx -dump in order to capture their plaintext
output.

Keep HTML where it belongs, on webpages, not mail. If someone wants to send
you an image, they can do so through an attachment.

Regards,

-- 
Paul Mundt <lethal@chaoticdreams.org>

