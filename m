Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268547AbRG3MOX>; Mon, 30 Jul 2001 08:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268545AbRG3MON>; Mon, 30 Jul 2001 08:14:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46351 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268547AbRG3MN5>; Mon, 30 Jul 2001 08:13:57 -0400
Subject: Re: Test mail
To: lethal@ChaoticDreams.ORG (Paul Mundt)
Date: Mon, 30 Jul 2001 13:15:21 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), indigoid@higherplane.net (john slee),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010730050749.A17726@ChaoticDreams.ORG> from "Paul Mundt" at Jul 30, 2001 05:07:49 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15RBxB-0003fv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> > ELM, Pine and Mutt have all at various times had holes that could have been
> > used to write an exact Unix equivalent of the windows virus. 
> > <img src="file:/dev/mouse"> hangs some web browser email 4 years after the
> > bug was reported and so on...
> > 
> This all goes back to opening things blindly, and also ties in the issue of
> HTML aware email clients.

Most exploits are header parsing flaws, HTML email is irrelevant to this
discussion.

> Mail clients should simply be dealing with plain text. As soon as things like
> HTML support are introduced into the client, you have the same sort of
> problems that you do with easily exploitable web browsers.

No. Most of them are header parsing flaws, they worked with plain text
email just fine. In fact HTML parsing vulnerabilities (other than privacy
violations) are pretty rare.

Alan
