Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSHOSRC>; Thu, 15 Aug 2002 14:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317305AbSHOSRC>; Thu, 15 Aug 2002 14:17:02 -0400
Received: from mail.gurulabs.com ([208.177.141.7]:10686 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S317302AbSHOSRB>;
	Thu, 15 Aug 2002 14:17:01 -0400
Date: Thu, 15 Aug 2002 12:20:54 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Kendrick M. Smith" <kmsmith@umich.edu>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>,
       "beepy@netapp.com" <beepy@netapp.com>,
       "trond.myklebust@fys.uio.no" <trond.myklebust@fys.uio.no>
Subject: Re: Will NFSv4 be accepted?
In-Reply-To: <Pine.LNX.4.44.0208151027510.3130-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208151209300.312-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2002, Linus Torvalds wrote:

> 
> For a good enough excuse, and with a good enough argument that it's not 
> likely to be a big export problem, I don't think it's impossible any more.
[snip]
> Quite frankly, I personally suspect that crypto is one of those things 
> that will be added by vendor kernels first - if vendors are willing to 
> handle whatever export issues there are, that's good, and if they aren't, 
> then the standard kernel cannot really force it upon them anyway.

FWIW, Red Hat ships the CIPE kernel module (VPN), so the US export issues
have already been looked at by them.

The US regulations can be found at:

http://w3.access.gpo.gov/bis/ear/ear_data.html

The Export Control Classification Number (ECCN) for the kernel IMHO would
be "NLR" (No License Required) because of the license exception for source
code found in §740.1(e)(2).

Dax

