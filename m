Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311839AbSDASDz>; Mon, 1 Apr 2002 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312366AbSDASDq>; Mon, 1 Apr 2002 13:03:46 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31858 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311839AbSDASDg>; Mon, 1 Apr 2002 13:03:36 -0500
Date: Mon, 1 Apr 2002 20:03:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jure Pecar <pegasus@telemach.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre5aa1 oops via kt266a
Message-ID: <20020401200309.R1331@dualathlon.random>
In-Reply-To: <20020401142557.171cb72e.pegasus@telemach.net> <20020401164813.138ad1ae.pegasus@telemach.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2002 at 04:48:13PM +0200, Jure Pecar wrote:
> 
> Looks like i panicked too early; it looks like the dimm in my board is
> misbehaving. I got another strange oops and sudnely bios deceided to
> recognize only half of it. gotta replace it asap ...

never mind, I just wanted to ask you about the ram, 90% of those
prune_dcache oopses are due bad ram. Thanks,

Andrea
