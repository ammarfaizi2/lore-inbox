Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129700AbRBNJME>; Wed, 14 Feb 2001 04:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131830AbRBNJLy>; Wed, 14 Feb 2001 04:11:54 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:24328 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129700AbRBNJLq>; Wed, 14 Feb 2001 04:11:46 -0500
Date: Wed, 14 Feb 2001 03:11:25 -0600
To: Eli Carter <eli.carter@inet.com>
Cc: Kai Henningsen <kaih@khms.westfalen.de>, matti.aarnio@zmailer.org,
        linux-kernel@vger.kernel.org
Subject: Re: lkml subject line
Message-ID: <20010214031125.B30531@cadcamlab.org>
In-Reply-To: <20010212133324.B15688@mea-ext.zmailer.org> <7vh2Hebmw-B@khms.westfalen.de> <3A885DFF.824AC093@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A885DFF.824AC093@inet.com>; from eli.carter@inet.com on Mon, Feb 12, 2001 at 04:04:47PM -0600
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Kai Henningsen]
> > There *is* a good way to do this, and it would be really nice if
> > vger could be taught to do it: add a List-Id: header
> > (draft-chandhok-listid-04.txt RFC-to-be, implemented in lots of
> > mailing list managers already).

[Eli Carter]
> Have you looked at the headers in an LK email?
> 
> Sender: linux-kernel-owner@vger.kernel.org
> X-Mailing-List:         linux-kernel@vger.kernel.org
> ^^^^^^^^^^^^^^ Should provide that List-Id you want.

You missed the point.  Certainly there are ways to identify LK mail.
Kai is saying that since 'List-Id:' is an IETF proposed standard,
Majordomo ought to use it.

Peter
