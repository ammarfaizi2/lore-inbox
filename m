Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSKCRzd>; Sun, 3 Nov 2002 12:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262298AbSKCRzd>; Sun, 3 Nov 2002 12:55:33 -0500
Received: from pcp470010pcs.westk01.tn.comcast.net ([68.47.207.140]:7845 "EHLO
	shed.7house.org") by vger.kernel.org with ESMTP id <S262296AbSKCRzc>;
	Sun, 3 Nov 2002 12:55:32 -0500
Message-ID: <3DC5648D.4E73400A@y12.doe.gov>
Date: Sun, 03 Nov 2002 13:01:49 -0500
From: David Dillow <dillowd@y12.doe.gov>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@intercode.com.au>
CC: Niels Provos <provos@citi.umich.edu>, linux-kernel@vger.kernel.org
Subject: Re: cryptographic acceleration [Re: What's left over.]
References: <Mutt.LNX.4.44.0211021857590.31595-100000@blackbird.intercode.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> 
> On Sat, 2 Nov 2002, Niels Provos wrote:
> 
> > On the other hand, there are some Ethernet cards that support inline
> > encryption so that not additional bus bandwidth is required to do both
> > public and symmetric key cryptography.
> 
> And this is precisely the case for which we have no detailed documentation
> at this stage.  Hardware which does this includes the Intel PRO/100S and
> 3Com 3CR990.

Have this for 3cr990, driver coming soon. I have docs under NDA for the crypto
as well, hope to be more active getting that going as soon as I get some more
free time.

D
