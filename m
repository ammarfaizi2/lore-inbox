Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135922AbRAWDli>; Mon, 22 Jan 2001 22:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135982AbRAWDl2>; Mon, 22 Jan 2001 22:41:28 -0500
Received: from purplecoder.com ([206.64.99.91]:61826 "EHLO
	gateway.purplecoder.com") by vger.kernel.org with ESMTP
	id <S135922AbRAWDlP>; Mon, 22 Jan 2001 22:41:15 -0500
Message-ID: <3A6CB402.8265A7B2@purplecoder.com>
Date: Mon, 22 Jan 2001 17:28:18 -0500
From: Mark I Manning IV <mark4@purplecoder.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ralf Baechle <ralf@uni-koblenz.de>, linux-kernel@vger.kernel.org
Subject: Re: Coding Style
In-Reply-To: <3A68809B.E12EF3D9@purplecoder.com> <20010121030005.B4626@emma1.emma.line.org> <20010122062442.B1052@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> 
> On Sun, Jan 21, 2001 at 03:00:05AM +0100, Matthias Andree wrote:
> 
> > >   int function(int x)
> > >   {
> > >     body of function    // correctly braced and commented :)
> > >   }
> >
> > So you claim // is a correct C comment? Poor guy :)
> 
> Current drafts of C9X implement // comments; virtually every halfway
> current C compiler I've used during the last years implements it.
> 
>   Ralf
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

Any plane vanilla C compiler that doesnt support // as a coment is
probably at least 10 years old :)  His point wasnt that it wouldnt work,
he was pointing out that this cmmenting style is frowned upon in C.  

It is alot neater tho :P~

// even for multi line comments 
// no visual clutter over there -->
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
