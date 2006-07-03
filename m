Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWGCRJx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWGCRJx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:09:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGCRJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:09:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:38814 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751202AbWGCRJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:09:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Zbr9zwH8s701IO/ZyBIomgUe79DcEiHP+UEtyf/vqFCyQ6EcTUJccizJ7lA82tD34CHM2o6qAYB9hX1jnA2yprXC5ITCcV/IrZFMxk37D5Uy8oEKfr8JUoudS8kT0ZoGQ3/cqKDwR/nBbYhr2AnFCc6uU28OnEOrU0PRzdBMeIo=
Message-ID: <44A94F5D.4050206@gmail.com>
Date: Mon, 03 Jul 2006 20:09:49 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060620)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Daniel Bonekeeper <thehazard@gmail.com>, kernelnewbies@nl.linux.org,
       linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>            <44A9030A.1020106@gmail.com> <200607031500.k63F0rO2014091@turing-police.cc.vt.edu>
In-Reply-To: <200607031500.k63F0rO2014091@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> On Mon, 03 Jul 2006 14:44:10 +0300, Alon Bar-Lev said:
> 
>> I hate when vendors like ATI, Conexant and UPEK publish binary drivers
>> without publishing the chipset spec... They should decide whether
>> their IP is on the software part or on the hardware part, if it is on
>> the hardware part, they are making money in selling the hardware. If
>> it is on the software part, there is no reason why not providing the
>> information for others to write software to work with the primitive
>> hardware. So in either case there should be full hardware interface
>> disclosure.
> 
> That's all fine and good, if the hardware design is entirely either
> stuff designed to open specs (for instance, the actual PCI interface
> chips, which *have* to behave a given way for the PCI bus to work) or
> your own design.
> 
> Things get much more difficult if your hardware design ends up incorporating
> somebody else's intellectual property, and they insist on such obfuscation
> as part of the licensing terms.  You then have two choices:
> 
> 1) Refuse to build and sell the board under such onerous requirements.
> 
> 2) Realize that 95% of the computers that could possibly use your board
> are running Windows and don't care about an open-source driver *anyhow*,
> accept the fact that you'll not be able to sell to that last 5%, and
> build it anyhow...
> 
> Only one of these choices generates revenue for your company.

This is not the situation in ATI, Conexant and UPK. They all 
manufacture chips, and they claim that the interface of the 
chip is their IP. I cannot accept this.

Let's take the Conexant case, I bought a computer (Thinkpad) 
with their modem. This means that I've paid for the hardware 
part.

Now this chip should be very primitive, it only allow the 
basic hardware support for software to produce the necessary 
waves.

They supply drivers for Windows for free, but they have sold 
the chip interface to 3rd party that sells!!! drivers for Linux.

They admit that they need no more money for the sale, but 
they don't publish the chip interface to allow others to 
develop appropriate software.

The secret should be on the software... But still they 
continue to limit the usage of the chip people payed money for.

And until now I did not discuss the low quality level of the 
linux binary drivers!

The same goes for ATI and others.

Best Regards,
Alon Bar-Lev.

