Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285347AbRLGAgO>; Thu, 6 Dec 2001 19:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbRLGAgF>; Thu, 6 Dec 2001 19:36:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:31036 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285348AbRLGAfx>;
	Thu, 6 Dec 2001 19:35:53 -0500
Date: Fri, 7 Dec 2001 01:35:46 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: viro@math.psu.edu, greg@kroah.com, jonathan@daria.co.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Q: device(file) permissions for USB
Message-Id: <20011207013546.586f8948.rene.rebe@gmx.net>
In-Reply-To: <200112070021.fB70Lik02148@vindaloo.ras.ucalgary.ca>
In-Reply-To: <20011207005707.6a09706a.rene.rebe@gmx.net>
	<Pine.GSO.4.21.0112061903230.29985-100000@binet.math.psu.edu>
	<200112070021.fB70Lik02148@vindaloo.ras.ucalgary.ca>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 17:21:44 -0700
Richard Gooch <rgooch@ras.ucalgary.ca> wrote:

> I gave it as much testing as I could, but there comes a point where
> you don't get any more test reports (because people are lazy) where
> you have to throw it out for a pre-patch which *will* get testing.
> I got tired of begging for people to test it.

OK. Here I'm send me all you would like to get tested!

> Basic chicken and egg problem. It's the same reason Linus released
> 2.4.0-test* when it was really 2.3.99++.

I use devfs for years on workstations. I never had major problems, only
that ALSA needs a few days to follow changes, and some string
cripling when modprobe is called (solved for months) ...

[...]

> Anyway, this is all semantics and history. All that matters is that
> the latest code is much better, and I'm working on getting the last
> wrinkles out. We're still in a pre-patch, so no need to panic yet.
> I've been diligent about fixing things (mostly battling with
> incomplete bug reports).

I try to get more details (than I had in the last IDE one) into my next
reports - sorry ;-)

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca


k33p h4ck1n6
  René

-- 
René Rebe (Registered Linux user: #248718 <http://counter.li.org>)

eMail:    rene.rebe@gmx.net
          rene@rocklinux.org

Homepage: http://www.tfh-berlin.de/~s712059/index.html

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
