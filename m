Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285335AbRLGAU7>; Thu, 6 Dec 2001 19:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285339AbRLGAUt>; Thu, 6 Dec 2001 19:20:49 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:18465 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S285335AbRLGAUo>;
	Thu, 6 Dec 2001 19:20:44 -0500
Date: Fri, 7 Dec 2001 01:20:37 +0100
From: Rene Rebe <rene.rebe@gmx.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: greg@kroah.com, jonathan@daria.co.uk, linux-kernel@vger.kernel.org,
        Clifford Wolf <clifford@clifford.at>,
        Valentin Ziegler <ziegler@informatik.hu-berlin.de>
Subject: Re: Q: device(file) permissions for USB
Message-Id: <20011207012037.71556cb0.rene.rebe@gmx.net>
In-Reply-To: <Pine.GSO.4.21.0112061903230.29985-100000@binet.math.psu.edu>
In-Reply-To: <20011207005707.6a09706a.rene.rebe@gmx.net>
	<Pine.GSO.4.21.0112061903230.29985-100000@binet.math.psu.edu>
Organization: FreeSourceCommunity ;-)
X-Mailer: Sylpheed version 0.6.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2001 19:09:57 -0500 (EST)
Alexander Viro <viro@math.psu.edu> wrote:

> On Fri, 7 Dec 2001, Rene Rebe wrote:
> 
> > > > usbdevfs does not require devfs, which enables the majority of Linux
> > > > users to actually use it.
> > > 
> > > s/majority of/& sane/
> > 
> > Writing bash scripts is easier than adding two lines to devfsd.conf?? Btw.
> > sane users do not use such a mahor/messy distro ...
> 
> Sane users don't run stuff with known unfixable security holes.  The only
> variant that has any promise to get that crap fixed got no testing to
> speak about.

Hm. OK. Due to lag of time I was too long not on the mailing-list. :-(
I this is true it is a very strong point aganst devfs :-[[

> Ask Richard if you don't believe me - or grep the l-k archives.  Again,
> all variants of devfs up to and including 2.4.16 are unfixable according
> to devfs author.

Hm.

> BTW, which distro are you talking about?

ROCK Linux (www.rocklinux.org)

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
