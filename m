Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281864AbRK1O4F>; Wed, 28 Nov 2001 09:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282936AbRK1Ozz>; Wed, 28 Nov 2001 09:55:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:53775 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S281864AbRK1Ozi>; Wed, 28 Nov 2001 09:55:38 -0500
Date: Wed, 28 Nov 2001 11:38:23 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, editors@newsforge.com,
        lwn@lwn.net
Subject: Re: Linux 2.4.16
In-Reply-To: <20011127083530.A13584@bee.lk>
Message-ID: <Pine.LNX.4.21.0111281137370.14166-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Nov 2001, Anuradha Ratnaweera wrote:

> On Mon, Nov 26, 2001 at 10:30:08AM -0200, Marcelo Tosatti wrote:
> > 
> > final:
> > - Fix 8139too oops				(Philipp Matthias Hahn)
> 
> Won't that be a good idea to keep the -final the same as the last -pre?

I don't see why: the 8139 fix has been tested and it _fixes_ and oops: Its
not an enhancement. 

