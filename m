Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319866AbSINL0G>; Sat, 14 Sep 2002 07:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319868AbSINL0G>; Sat, 14 Sep 2002 07:26:06 -0400
Received: from mail.zmailer.org ([62.240.94.4]:30436 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S319866AbSINL0F>;
	Sat, 14 Sep 2002 07:26:05 -0400
Date: Sat, 14 Sep 2002 14:30:53 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Andrew Bray <andy@chaos.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ADMIN: DON'T try to be clever with email headers!
Message-ID: <20020914113053.GH30392@mea-ext.zmailer.org>
References: <20020913173709.GG30392@mea-ext.zmailer.org> <Pine.LNX.4.44.0209132257210.29038-100000@madhouse.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209132257210.29038-100000@madhouse.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 14, 2002 at 12:16:15AM +0100, Andrew Bray wrote:
> Hi Matti,
...
> > On Fri, Sep 13, 2002 at 03:49:01PM +0000, Andrew Bray wrote:
> > > To:	<linux-kernel@vger.kernel.org>
> > > From:	abuse@madhouse.demon.co.uk (Andrew Bray)
> > > Subject: Re: [PATCH] drivers/pci,hamradio,scsi,aic7xxx,video,zorro clean and mrproper files 4/6
> > > Date:	13 Sep 2002 15:49:01 GMT
> > > Organization: Private Internet Node
> > > Message-ID: <slrnao427d.si3.abuse@madhouse.demon.co.uk>
> > > Reply-To:	andy@@chaos.org.uk
> 
> I object!
> 
> There is nothing 'cute' in this header, and I didn't post a patch, just a
> comment on one.  It was entirely correct SMTP, with a truly unique message
> ID and all addresses were valid for sending replies (From:, and
> Reply-To:), and all arrive to me.

  Look closer at the "Reply-To:" header.  THAT caused tons of bounces.

  You didn't post a patch, but there has been recently quite a lot of
  talk about patches not reaching people when they filter things, and
  throw messages with even slightly suspicuous headers into dev-null..

....  (lots of semi-relevant text (which I even agree with) dropped ..)

  I really would love to have a globally functional email system
  where everybody sends PGP encrypted messages over SSL encrypted
  email connections, everybody posts to LIST public key, list opens
  it up, and posts to each recipient's public key..
  TONS of encryption work at the list processors, of course..

  How can that prevent the list from making into spammers address
  harvesters ?  Not anymore than the current situation.  Any list
  archive with open access is prone to reveal the addresses.

> Regards,
> Andy
>----------------------------------------------------------------------------
> Andrew Bray, PWMS, MA,              |  preferred:    mailto:andy@chaos.org.uk
> London, England                     |  or:   mailto:andy@madhouse.demon.co.uk
