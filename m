Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRA2VC1>; Mon, 29 Jan 2001 16:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129878AbRA2VCH>; Mon, 29 Jan 2001 16:02:07 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:40781 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S129431AbRA2VCA>; Mon, 29 Jan 2001 16:02:00 -0500
Date: Mon, 29 Jan 2001 23:01:47 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Knowing what options a kernel was compiled with
Message-ID: <20010129230147.H1002@niksula.cs.hut.fi>
In-Reply-To: <4461B4112BDB2A4FB5635DE1995874320223F3@mail0.myrio.com> <032601c08a36$0c8d5570$0100a8c0@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <032601c08a36$0c8d5570$0100a8c0@homeip.net>; from eccesys@topmail.de on Mon, Jan 29, 2001 at 08:56:12PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 08:56:12PM -0000, you [mirabilos] claimed:
> From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
> > Should someone submit a patch to copy the .config to a standard location as
> > part of "make install" or "make modules_install"? If included in the
> > official sources, that good example would encourage the distribution
> > maintainers do the same. 

I find this neat:

http://www.it.uc3m.es/~ptb/proconfig/

It created /proc/config entry with obvious functionality, but wastes
pretty little ram.


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
