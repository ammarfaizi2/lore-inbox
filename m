Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135264AbRDWOrv>; Mon, 23 Apr 2001 10:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRDWOrd>; Mon, 23 Apr 2001 10:47:33 -0400
Received: from ns.snowman.net ([63.80.4.34]:54276 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S135264AbRDWOrA>;
	Mon, 23 Apr 2001 10:47:00 -0400
Date: Mon, 23 Apr 2001 10:46:15 -0400 (EDT)
From: <nick@snowman.net>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Bram Smout <bram@ba.be>, linux-kernel@vger.kernel.org
Subject: Re: SGI Visual Workstation Support
In-Reply-To: <20010423164013.K2615@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.21.0104231046010.9607-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is documantation available for the VW?
	Nick

On Mon, 23 Apr 2001, Erik Mouw wrote:

> On Mon, Apr 23, 2001 at 10:12:14PM +0200, Bram Smout wrote:
> > If I try to compile a 2.4.x (0-3) kernel for my SGI 540 Workstation and I
> > enable SGI Virtual Workstation support (under general setup) the compilation
> > stops with the error "kernel.o: In function 'enable_irq' etc...".
> > 
> > Previous kernels, such as 2.2.19 compile without any problem (same options).
> > Anyone a idea of what's wrong ?
> 
> Bit rot. Nobody actually has a SGI VW, so it's currently not
> maintained.
> 
> 
> Erik
> 
> -- 
> J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
> of Electrical Engineering, Faculty of Information Technology and Systems,
> Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
> Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
> WWW: http://www-ict.its.tudelft.nl/~erik/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

