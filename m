Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136127AbRAGR4C>; Sun, 7 Jan 2001 12:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132260AbRAGRzw>; Sun, 7 Jan 2001 12:55:52 -0500
Received: from mail.inconnect.com ([209.140.64.7]:5082 "HELO
	mail.inconnect.com") by vger.kernel.org with SMTP
	id <S136127AbRAGRzg>; Sun, 7 Jan 2001 12:55:36 -0500
Date: Sun, 7 Jan 2001 10:55:35 -0700 (MST)
From: Dax Kelson <dax@gurulabs.com>
To: Alan Olsen <alan@clueserver.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
In-Reply-To: <Pine.LNX.4.10.10101061928340.1843-100000@clueserver.org>
Message-ID: <Pine.SOL.4.30.0101071054080.17990-100000@ultra1.inconnect.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Olsen said once upon a time (Sat, 6 Jan 2001):

> On Sat, 6 Jan 2001, Michael D. Crawford wrote:
>
> > AGP, VIA support, DRM, and r128 DRM are all compiled in statically rather than
> > as modules.
>
> AGPGART doe *not* work if compiled statically.  Compile it as a module.
> You will be much happier. (i.e. It might actually work.)  I would also
> compile DRM and the r128 drivers as modules as well.

AGPGART works fine for me compiled in.

Dax

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
