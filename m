Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311264AbSDSGLb>; Fri, 19 Apr 2002 02:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSDSGLa>; Fri, 19 Apr 2002 02:11:30 -0400
Received: from smtp2.san.rr.com ([24.25.195.39]:21955 "EHLO smtp2.san.rr.com")
	by vger.kernel.org with ESMTP id <S311264AbSDSGLa>;
	Fri, 19 Apr 2002 02:11:30 -0400
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for
	2.5.8(take 2)
From: George J Karabin <gkarabin@pobox.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        David Brownell <david-b@pacbell.net>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <16yRDq-2G4UamC@fmrl04.sul.t-online.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-3) 
Date: 18 Apr 2002 23:11:22 -0700
Message-Id: <1019196683.1733.34.camel@pane.chasm.dyndns.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-18 at 22:46, Oliver Neukum wrote:
> Too short a difference. You easily skip it reading and there's a chance of typos.
> Furthermore the first latter should differ for tab completion.
> Target is actually quite good a name. It makes clear that there's only
> one initiator of transactions on USB.

Those are good points. The shortcomings you mentioned are solved easily
enough, although the solutions that come to mind may not sound much
better either. 

Easy tab completion could be provided using prefixes instead of
suffixes, like l and lh for lhusb and husb. Alternately, you could use
the long forms localusb, local-usb, or local_usb, or hostusb, host-usb,
or host_usb, taking care of the "too short a difference" concern. I'm
not sure these solutions are any better.

That said, target or client or anything else distinctive sounds fine
too. I'm just partial to the spec-derived-naming idea. (Although I
really wish the USB spec folks could have come up with two names that
were more descriptively different...)

- George


