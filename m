Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288925AbSA2IIx>; Tue, 29 Jan 2002 03:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288930AbSA2IIm>; Tue, 29 Jan 2002 03:08:42 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:47286 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S288925AbSA2IIh>; Tue, 29 Jan 2002 03:08:37 -0500
Date: Tue, 29 Jan 2002 09:07:51 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: "Calin A. Culianu" <calin@ajvar.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Steven Hassani <hassani@its.caltech.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Athlon Optimization Problem
In-Reply-To: <Pine.LNX.4.30.0201281551250.2376-100000@rtlab.med.cornell.edu>
Message-ID: <Pine.LNX.4.40.0201290900490.7168-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2002, Calin A. Culianu wrote:

> Hmm.  What do you recommend?  I remember seeing a spec sheet and register
> 0x95 was the memory write queue timer.. but I could have dreamed it..
>
> Anyone know what register 0x95 does?

hmmm ... when i was working on the athlon disconnect patch i found that
the pcr files (resorce files) for the wpcredit programm (windows tool for
changing the configuration of chipset) are a good source of information.
but this register isn't discribed in this file ... sorry

daniel
(i placed the pcr file on the web, if you are interested, have a look at:
http://cip.uni-trier.de/nofftz/linux/kt266_pcr.txt ... the webserver is
down at the moment, but should be up again in 1-2 hours)


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de

