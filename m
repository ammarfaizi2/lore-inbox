Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136054AbRAWDbQ>; Mon, 22 Jan 2001 22:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136055AbRAWDa4>; Mon, 22 Jan 2001 22:30:56 -0500
Received: from sgigate.SGI.COM ([204.94.209.1]:25335 "EHLO
	gate-sgigate.sgi.com") by vger.kernel.org with ESMTP
	id <S136054AbRAWDaw>; Mon, 22 Jan 2001 22:30:52 -0500
Date: Mon, 22 Jan 2001 06:24:42 -0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Coding Style
Message-ID: <20010122062442.B1052@bacchus.dhis.org>
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com> <20010121030005.B4626@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010121030005.B4626@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Sun, Jan 21, 2001 at 03:00:05AM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 21, 2001 at 03:00:05AM +0100, Matthias Andree wrote:

> >   int function(int x)   
> >   {
> >     body of function    // correctly braced and commented :)
> >   }
> 
> So you claim // is a correct C comment? Poor guy :)

Current drafts of C9X implement // comments; virtually every halfway
current C compiler I've used during the last years implements it.

  Ralf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
