Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262643AbREOGAF>; Tue, 15 May 2001 02:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbREOF7z>; Tue, 15 May 2001 01:59:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40722 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262643AbREOF7l>; Tue, 15 May 2001 01:59:41 -0400
From: "H. Peter Anvin" <hpa@transmeta.com>
Message-ID: <3B00C5B5.C9738219@transmeta.com>
Date: Mon, 14 May 2001 22:59:17 -0700
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Alexander Viro <viro@math.psu.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105141852140.19333-100000@weyl.math.psu.edu> <3B006229.EA65A868@transmeta.com> <01051507563500.01598@idun>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> >
> > That's not the issue.  LILO takes whatever you pass to root= and converts
> > it to a device number at /sbin/lilo time.  An idiotic practice on the
> > part of LILO, in my opinion, that ought to have been fixed a long time
> > ago.
> 
> And happily passes a "root=" argument through "append=" for the kernel to
> evaluate.
> 

Sure, but it's not the way they have convinced users to set their systems
up.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
