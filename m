Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265766AbSJaXOk>; Thu, 31 Oct 2002 18:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265734AbSJaXNo>; Thu, 31 Oct 2002 18:13:44 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:63455 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265722AbSJaXN1>;
	Thu, 31 Oct 2002 18:13:27 -0500
Message-ID: <3DC1BA25.90408@gmx.net>
Date: Fri, 01 Nov 2002 00:17:57 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Xiafs inclusion in 2.5?
References: <3DC18308.1040808@gmx.net>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
 > Carl-Daniel Hailfinger wrote:
> > Hello Linus,
> > 
> > somewhere back in 2000, you [Linus Torvalds] wrote:
> > > Who still remembers xiafs? We have 33 different filesystems in
 > > > the kernel tree - something that is quite impressive, and something
 > > > that I don't think anybody else has ever tried to support.
> > > But we could have had 34.
> >
> > Out of curiosity, would you reaccept xiafs in 2.5, if it was cleaned
> > up and forward ported to use the new interfaces?
> > And if you accept it, what's the latest date I could submit it?
> > Technically, it is a regression, ;-) so the feature freeze date
 > > might not apply.
> > 
> 
> Not to be flippant, but really... what's the point?
> 

There are several:
- Trying to fulfill what I percieve to be a wish of Linus which nobody
   has cared for
- Being able to recover *very* old data without having to dig out a
   compiler+computer suitable for 2.0 kernels
- Linux is supposed to be fun (The point which matters)

Regards,
Carl-Daniel

P.S. Please CC me because my subscription to lkml seems to be hosed.

