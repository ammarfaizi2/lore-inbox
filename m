Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129596AbQLDATe>; Sun, 3 Dec 2000 19:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbQLDATZ>; Sun, 3 Dec 2000 19:19:25 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:38151 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129596AbQLDATL>; Sun, 3 Dec 2000 19:19:11 -0500
Date: Sun, 3 Dec 2000 17:44:58 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Phantom PS/2 mouse persists..
Message-ID: <20001203174458.A24652@vger.timpanogas.org>
In-Reply-To: <20001203161940.A24531@vger.timpanogas.org> <Pine.LNX.4.21.0012031739360.3253-100000@pii.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0012031739360.3253-100000@pii.fast.net>; from shirsch@adelphia.net on Sun, Dec 03, 2000 at 05:42:03PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2000 at 05:42:03PM -0500, Steven N. Hirsch wrote:
> On Sun, 3 Dec 2000, Jeff V. Merkey wrote:
> 
> > > On Sun, Dec 03, 2000 at 06:27:52PM +0000, Alan Cox wrote:
> > > > 
> > > > I've fixed the major case. I can see no definitive answer to the other ghost
> > > > PS/2 stuff (except maybe USB interactions). I take it like the others 2.4test
> > > > also misreports a PS/2 mouse being present.
> > > > 
> > > > Anyway I think its no longer a showstopper for 2.2.18. Someone with an affected
> > > > board can piece together the picture
> 
> > I just tested 2.2.18-24 as a boot kernel with anaconda -- works great -- 
> > mouse problem on PS/2 system is nailed.  
> 
> <sigh>  I always seem to own the wierd hardware.  I agree the mouse
> mis-detection isn't a showstopper - just damn annoying.
> 
> FWIW, USB isn't compiled into the kernel in question.

Yes it is.  I am also seeing compile problems.  I will post to a new subject
since they are not mouse related, but IPVS related.

Jeff


> 
> Steve
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
