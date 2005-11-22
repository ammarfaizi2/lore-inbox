Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVKVIIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVKVIIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 03:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVKVIIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 03:08:11 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15526 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S964841AbVKVIIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 03:08:10 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Neil Brown <neilb@suse.de>
Subject: Re: [RFC] Small PCI core patch
Date: Tue, 22 Nov 2005 10:07:12 +0200
User-Agent: KMail/1.8.2
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
References: <20051121225303.GA19212@kroah.com> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <17282.39560.978065.606788@cse.unsw.edu.au>
In-Reply-To: <17282.39560.978065.606788@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511221007.12833.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 November 2005 06:11, Neil Brown wrote:
> I doubt they will see 'the light' for many years without dollar signs
> attached.
> 
> A question worth asking is: Who needs whom?  Do we (FLOSS community)
> need them (Graphics hardware manufactures) or do they need us?
> Despite growth in Linux on Desktops, I think we need them a lot more
> than they need us.
[snip] 
> Who is going to pay these people to do this work?  If you agree with
> the analysis of 'who needs whom', the logical answer is 'us'.
> 
> Maybe we need a small consortium of companies with vested interest in
> OSS each ponying up half a million, and use this to employ two teams
> of graphics experts, one of which works within NVidia, and one within
> ATI.  I suspect the two companies could be convinced to take on some
> free engineering support, if it was presented the right way.
> 
> Anyone got a few dollars to spare?

Historically hackers were not too good at raising funds.

Maybe we should use stuff which we are good at? Forcedeth
is a nice precedent. 2d and especially 3d engines
may be significantly harder to reverse engineer,
but people can scale rather nicely, as kernel development shows. ;)

Then write specs from gained knowledge and put it on a web page.

IIRC reverese engineering for driver development is legal
in most countries.

If ATI/NVidia will sue Linux on this, then server-oriented companies
(RedHat, IBM, ...) probably could provide defence.
--
vda
