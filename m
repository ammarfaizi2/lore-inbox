Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbRE2ADb>; Mon, 28 May 2001 20:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261824AbRE2ADV>; Mon, 28 May 2001 20:03:21 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:38161 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261823AbRE2ADL>;
	Mon, 28 May 2001 20:03:11 -0400
Date: Tue, 29 May 2001 02:03:00 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: James Sutherland <jas88@cam.ac.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, lm@bitmover.com,
        aaronl@vitelus.com, acahalan@cs.uml.edu, dledford@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010529020300.A6061@pcep-jamie.cern.ch>
In-Reply-To: <200105260310.UAA15624@baldur.yggdrasil.com> <Pine.SOL.4.33.0105261157080.21081-100000@orange.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SOL.4.33.0105261157080.21081-100000@orange.csi.cam.ac.uk>; from jas88@cam.ac.uk on Sat, May 26, 2001 at 12:00:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:
> Note the "derived work"; there is no way on this earth (or any other) that
> you could regard the device's firmware as being a "derived work" of the
> driver!

The same is true if you add another completely new and separately
written .c source file: the new file is not a derived work of the
driver.  The GPL even has an explicit provision to make it clear that
the GPL covers only the combined work, and the individual components
continue to be available under their original terms.

> AFAICS, the firmware is just a file served up to the device as needed
> - no more a derivative work from the kernel than my homepage is a
> derivative work of Apache.

Indeed.  But if you compiled your home page, linked it into Emacs to
display on startup, and distributed the binary, the _combination_
"Emacs+homepage" binary would be a derived work, and you'd be required
to offer source for both parts.

It is the combination which is considered a derived work, and the GPL
terms apply to a combination when any of the parts is GPLed.  (Otherwise
you aren't granted permission to distributed the combination).

Combination, as ever, is different from "mere aggregation" and that's
where so many arguments begin...

-- Jamie
