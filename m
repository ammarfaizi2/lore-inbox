Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317460AbSFCTXk>; Mon, 3 Jun 2002 15:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSFCTXj>; Mon, 3 Jun 2002 15:23:39 -0400
Received: from mail.zmailer.org ([62.240.94.4]:60105 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S317460AbSFCTXh>;
	Mon, 3 Jun 2002 15:23:37 -0400
Date: Mon, 3 Jun 2002 22:23:38 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: please kindly get back to me
Message-ID: <20020603222338.F18899@mea-ext.zmailer.org>
In-Reply-To: <61DB42B180EAB34E9D28346C11535A783A7801@nocmail101.ma.tmpw.net> <20020603220046.D18899@mea-ext.zmailer.org> <20020603120653.C4940@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2002 at 12:06:53PM -0700, Larry McVoy wrote:
> On Mon, Jun 03, 2002 at 10:00:46PM +0300, Matti Aarnio wrote:
> >   Anti-spam technology really needs constant evolution, as those
> >   spammers do evolve themselves...
> 
> If ever there was something which was screaming for an open source project,
> it's spam filtering.  It seems like every major mailing list has someone
> like Matti, working really hard on a thankless task, but losing out under
> the tide of new spam every day.  Seems to me if there was a public repository
> (sourceforge, bkbits, whatever) with a collection of procmail filters which
> have been shown to work correctly, that would be a win.

  Larry,

  Best technologies (as I see them, but I am not omniscient, of course)
  are those that do scoring.  E.g. naving some word NN might not alone
  be considered spam-signature, but it might increase score, and once
  the score exceeds arbitrary treshold (lower with short messages?),
  the message is considered spam, and rejected.

  Some recent TEXT/PLAIN spams have been encoded in BASE64 or ingenous
  QUOTED-PRINTABLE to avoid several common Perl-RE pattern using filters.

  I think there are several free codes of this kind available, but my time
  has been chronically over-subscribed to do radical things like taking
  this kind of codes into use.

> -- 
> Larry McVoy     lm at bitmover.com     http://www.bitmover.com/lm 

/Matti Aarnio
