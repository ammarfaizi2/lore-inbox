Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285516AbSA2W7x>; Tue, 29 Jan 2002 17:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSA2W7o>; Tue, 29 Jan 2002 17:59:44 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:65021 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S285516AbSA2W73>; Tue, 29 Jan 2002 17:59:29 -0500
Date: Tue, 29 Jan 2002 23:59:11 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@hades.uni-trier.de
To: "Calin A. Culianu" <calin@ajvar.org>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Steven Hassani <hassani@its.caltech.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.LNX.4.30.0201291553360.10200-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.4.40.0201292353260.4360-100000@hades.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Calin A. Culianu wrote:

> Thank you kindly, Daniel.  It's strange that register 95 is ommitted.  We
> definitely can conclude that register 55 is not the one to set on the
> kt266 motherboards (whereas on the other via motherboards it *is* the one
> to set...  I even have the spec sheet to prove it! :) )

oh .. .there are some differences between the registers in the chipsets
... the kt 133 and the kt133 are very simmilar, the kx133 also ... the
kt266 and 266a are a bit different from the kt/kx ....
i uped the pcr files for the kt133 and kx133 also
so the urls for the three files:
http://cip.uni-trier.de/nofftz/linux/kt266_pcr.txt
				     kt133_pcr.txt
				     kx133_pcr.txt
this are all i have at the moment ...

> I really wish VIA were more willing to cooperate with us and give us spec
> sheets.  It's to their advantage to have us make their buggy motherboards
> work well with linux, for crying out loud!  I really don't get what the
> big deal is.  I mean it's not like the concept of setting bytes on a pci
> device to change functionality is so revolutionary it deserves to be
> obfuscated...

yes ... the support of via and some other big vendors could really be
better :(
maybee they are getting used to that we do the work for them ...

daniel

# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

