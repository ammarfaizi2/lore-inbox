Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317883AbSGVWqW>; Mon, 22 Jul 2002 18:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317886AbSGVWqW>; Mon, 22 Jul 2002 18:46:22 -0400
Received: from angelica.unixdaemons.com ([209.148.64.135]:36624 "EHLO
	angelica.unixdaemons.com") by vger.kernel.org with ESMTP
	id <S317883AbSGVWqU>; Mon, 22 Jul 2002 18:46:20 -0400
Date: Mon, 22 Jul 2002 18:49:20 -0400
From: Hiten Pandya <hiten@angelica.unixdaemons.com>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Message-ID: <20020722184920.A46977@angelica.unixdaemons.com>
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>; from landley@trommello.org on Thu, Jul 18, 2002 at 06:33:54PM -0400
X-Operating-System: FreeBSD i386
X-Public-Key: http://www.pittgoth.com/~hiten/pubkey.asc
X-URL: http://www.unixdaemons.com/~hiten
X-PGP: http://pgp.mit.edu:11371/pks/lookup?search=Hiten+Pandya&op=index
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote the words in effect of:
> From: Rob Landley <landley@trommello.org>
> To: linux-kernel@vger.kernel.org
> Subject: Alright, I give up.  What does the "i" in "inode" stand for?

> I've been sitting on this question for years, hoping I'd come across the 
> answer, and I STILL don't know what the "i" is short for.  Somebody here has 
> got to know this. :)

The "I" in "Inode" stands for "Index".  Think of it in this way, the
Inode is unique, it is the "index" by which you refer to a specific
file.

FWIW, this definition is used in many computer science texts, also in
JFS Layout paper I think.  I confirmed my definition with various
sources.

> [...]

Hope this helps. Btw, this is the first time I am posting to lkml.
Thank You.

--
Hiten Pandya
http://www.unixdaemons.com/~hiten
hiten@unixdaemons.com, hiten@uk.FreeBSD.org, hiten@xMach.org
PGP: http://pgp.mit.edu:11371/pks/lookup?search=Hiten+Pandya&op=index
