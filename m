Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319826AbSIMXYC>; Fri, 13 Sep 2002 19:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319827AbSIMXYB>; Fri, 13 Sep 2002 19:24:01 -0400
Received: from madhouse.demon.co.uk ([158.152.8.97]:51413 "EHLO
	madhouse.demon.co.uk") by vger.kernel.org with ESMTP
	id <S319826AbSIMXXx>; Fri, 13 Sep 2002 19:23:53 -0400
Date: Sat, 14 Sep 2002 00:16:15 +0100 (BST)
From: Andrew Bray <andy@chaos.org.uk>
Reply-To: Andrew Bray <andy@chaos.org.uk>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Andrew Bray <abuse@madhouse.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ADMIN: DON'T try to be clever with email headers!
In-Reply-To: <20020913173709.GG30392@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.44.0209132257210.29038-100000@madhouse.demon.co.uk>
Organization: Private Internet Node
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

Hi Matti,

On Fri, 13 Sep 2002, Matti Aarnio wrote:

>   Folks, when aiming to post into VGER's lists, DO NOT
>   try to make any cute things in headers.  Any such
>   are bound to cause TONS of bounces, which did happen
>   in this particular case...
> 
>   This is particularly important when posting patches..
> 
> 
> On Fri, Sep 13, 2002 at 03:49:01PM +0000, Andrew Bray wrote:
> > To:	<linux-kernel@vger.kernel.org>
> > From:	abuse@madhouse.demon.co.uk (Andrew Bray)
> > Subject: Re: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and mrproper files 4/6
> > Date:	13 Sep 2002 15:49:01 GMT
> > Organization: Private Internet Node
> > Message-ID: <slrnao427d.si3.abuse@madhouse.demon.co.uk>
> > Reply-To:	andy@@chaos.org.uk

I object!

There is nothing 'cute' in this header, and I didn't post a patch, just a
comment on one.  It was entirely correct SMTP, with a truly unique message
ID and all addresses were valid for sending replies (From:, and
Reply-To:), and all arrive to me.

The SMTP envelope from address (which you didn't include) is another valid 
address which I don't expect to cause trouble: mail-list@madhouse).

abuse@madhouse is a perfectly valid e-mail address on this machine, and 
andy@chaos is an address which will always reach me, even if I leave 
demon.

I chose abuse as an address, because I have received many spam messages 
offering 'cleaned' address lists where obvious 'trap-door' addresses were 
filtered out - 'abuse@' was explicitely mentioned.  This I count as a 
success, because, despite using abuse@ in the From: address in all news 
and mailing list postings for six years, only 14% of my incoming spam is 
sent to abuse@madhouse. (Interestingly, only 1% of incoming spam is sent 
to my Reply-To: address).

I cannot imagine why folks would want to trap abuse as a From: address, 
because in the thousands of spam messagess I have received over the last 
ten years, NONE have had abuse in either the envelope from address, or the 
SMTP From: header.

abuse is traditionally a destination address for reporting abuse to ISPs, 
for example demon have an email address for reporting abuse by customers 
which is abuse@demon.co.uk

I argue that the bounces are coming from mis-configured MTAs, as:

1) They should be bouncing on the envelope-from address rather than the 
   From: header, as the envelope address is more likely to be valid.  MTAs 
   shoud regard the From: address as a comment, because it is so readily 
   forged.

2) abuse is a silly address to trap, as it just doesn't happen in spam.

I use a threading news reader to read linux-kernel, and the scripts I use 
can easily munge the From: address to point back to the processor (I 
belong to some mailing lists that only accept postings from the address 
that is registered), but then then the mail would have a From: address 
that isn't read by a human, which in my opinion is real abuse.

This mailing list is gatewayed to a number if widely available usenet 
newsgroups, so I am loath to return to using my 'real' address in the 
From: header.

Regards,

Andy

- -- 
- -----------------------------------------------------------------------------
Andrew Bray, PWMS, MA,              |  preferred:    mailto:andy@chaos.org.uk
London, England                     |  or:   mailto:andy@madhouse.demon.co.uk
PGP id/fingerprint:  D811F5C9/26 B5 42 C6 F4 00 B2 71 BA EA 9B 81 6C 65 59 07

-----BEGIN PGP SIGNATURE-----
Version: 2.6.2i

iQCVAwUBPYJx0kjMoRfYEfXJAQFV1AP8DPA4kWPQ3xHYMiRK7c4vdhRg9DzKt/TP
yuEIZQkYBv1F+Lhv7kuNsQ5f8VkREYF0MvBih+liMIRIRBZqbxofwnm/59+rz/aZ
GrpwSPXm3cCbkC9eyuTDTlTcdNmoGk5sVwyirLBYHb4mr8mvpJM9dE6ND2KoaLjS
gTEqNIjjfxU=
=fZlb
-----END PGP SIGNATURE-----

