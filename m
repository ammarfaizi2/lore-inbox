Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312711AbSDFSbh>; Sat, 6 Apr 2002 13:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312712AbSDFSbg>; Sat, 6 Apr 2002 13:31:36 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:45580 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S312711AbSDFSbf>; Sat, 6 Apr 2002 13:31:35 -0500
Date: Sat, 6 Apr 2002 12:31:32 -0600
To: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Announce: Kernel Build for 2.5, Release 2.0 is available
Message-ID: <20020406183132.GF13991@cadcamlab.org>
In-Reply-To: <6529.1018004347@ocs3.intra.ocs.com.au> <20020405110913.GA11374@atrey.karlin.mff.cuni.cz> <20020405132324.L4640@csr-pc6.local> <20020405182504.GN961@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Sebastian Heidl]
> > It's signed. Just pipe it through gpg with Keiths public key.

[Mike Fedyk]
> Signed means that there is a checksum at the bottom that you can
> verify with gpg/pgp to see if the message was tampered with, but the
> text itself it still in ascii and not encoded.

Not that it matters (he did send out a reprint) but the message *was*
merely signed.  The base64-looking encoding is merely a way to make
sure that MTAs and other software don't screw with tabs, line breaks,
etc., which would make the signature look invalid.

> This looks encrypted to me.

It doesn't look encrypted to gpg.  Pipe the message to it, you'll see.

Peter
