Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbRE2Azs>; Mon, 28 May 2001 20:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261926AbRE2Azi>; Mon, 28 May 2001 20:55:38 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:2826 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261921AbRE2Aze>;
	Mon, 28 May 2001 20:55:34 -0400
Date: Tue, 29 May 2001 02:55:26 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: James Sutherland <jas88@cam.ac.uk>, "Adam J. Richter" <adam@yggdrasil.com>,
        lm@bitmover.com, aaronl@vitelus.com, acahalan@cs.uml.edu,
        dledford@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010529025526.D6061@pcep-jamie.cern.ch>
In-Reply-To: <20010529020300.A6061@pcep-jamie.cern.ch> <E154XJi-0003jI-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E154XJi-0003jI-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 29, 2001 at 01:24:58AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > > AFAICS, the firmware is just a file served up to the device as needed
> > > - no more a derivative work from the kernel than my homepage is a
> > > derivative work of Apache.
> > 
> > Indeed.  But if you compiled your home page, linked it into Emacs to
> > display on startup, and distributed the binary, the _combination_
> > "Emacs+homepage" binary would be a derived work, and you'd be required
> > to offer source for both parts.
> 
> In which case GNU Emacs violates the GPL by containing a copy of
> COPYING which is more restricted than the GPL. After all it displays
> copying on a hotkey combination
> 
> Is that really what you are trying to say ??

Interesting idea.  But no, not at all -- that would be daft!

Whether COPYING, or any other file, is displayed on a hotkey combination
is irrelevant.  My copy of Mozilla can pop up google.com on a mouse
click; there is no implication that Mozilla and google.com are a single
copyrighted entity.  

However, if Mozilla had the Google search engine built in to it, then of
course that instance of the Google code would have to be distributed
under MPL-compatible terms.  If Mozilla simply had the Google front page
built into it as internal "moz_printf" statements, then that code would
have to be MPL-compatible in order to be distributed.

There might be absurd technicalities if COPYING were part of the "source
code" for Emacs ("the Program").  Fortunately COPYING is not part of the
source code of an Emacs binary, because you don't need COPYING to build
the binary.

-- Jamie
