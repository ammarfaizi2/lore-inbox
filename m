Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317498AbSHLIjL>; Mon, 12 Aug 2002 04:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSHLIjL>; Mon, 12 Aug 2002 04:39:11 -0400
Received: from mail.zmailer.org ([62.240.94.4]:20962 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317498AbSHLIjK>;
	Mon, 12 Aug 2002 04:39:10 -0400
Date: Mon, 12 Aug 2002 11:42:58 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: "Dhr N. Van Alphen" <mastex@servicez.org>
Cc: Jim Roland <jroland@roland.net>, linux-kernel@vger.kernel.org
Subject: Re: The spam problem.
Message-ID: <20020812084258.GT32427@mea-ext.zmailer.org>
References: <027104643010c82DTVMAIL11@smtp.cwctv.net> <5.1.0.14.2.20020812064112.00b6b9c0@pop.gmx.net> <004e01c241bb$816847e0$2102a8c0@gespl2k1> <001c01c241bd$37fbabe0$0200010a@jennifer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c01c241bd$37fbabe0$0200010a@jennifer>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Good morning,

Please refrain from fights on email issues while I am asleep..
DaveM is in California, I am in Finland.  About 9-10 hours
time difference there.  (depending on our personal rythms, also.)

On Mon, Aug 12, 2002 at 07:00:46AM +0200, Dhr N. Van Alphen wrote:
> cause there would be many non-members who wanna post bugs but can't because
> they dont have access maybe?
> 
> I suggest too block every email adres wich sends crap, easy done.

 Consider:
    - Number of faked source addresses
    - Number of cases using somebody's address
    - Number of throw-away addresses
    - How many times they use  HOTMAIL/YAHOO/EMAIL/MAIL/... addresses ?

  I think I will stick to the (weakish) method of matching texts in
  message body (and sometimes on headers)..

  I just reviewed Majordomo's BOUNCE log.  It is bouncing (into oblivion)
  practically every posting from HOTMAIL (because of Received: header 
  text: "from mail pickup service", which appears also in a number of
  looped messages..)

  Over past 3 days  Majordomo  has trapped ONE of those money-scam
  letters.   A lot more of various other spams have been blocked.
  Messages with HTML content don't make it into VGER at all, which
  should give a very big clue to legitimate posters making a mistake
  of posting such.


  I am very worried of trapping too much.  A bit of leakage is (to me)
  accptable, but similar amounts of falsely trapped ones I don't like.

  I also receive so much spam directly, that I don't always detect every
  instance when it is leaking thru VGER's lists.   If you want to raise
  the attention of VGERs postmasters, I suggest you forward it to:

              postmaster@vger.kernel.org

  with subject: "leaked spam"

  Also, in case of non-english spam, I would like to receive suggestions
  for PERL RE patterns matching juicy keywords in the messages.
  (To me Chinese or Russian texts are just line noise...)

> Niek van alphen
> mastex@servicez.org

/Matti Aarnio
