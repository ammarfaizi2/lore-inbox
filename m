Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266069AbRGLG6P>; Thu, 12 Jul 2001 02:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267420AbRGLG6G>; Thu, 12 Jul 2001 02:58:06 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:35348 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S266069AbRGLG5v>; Thu, 12 Jul 2001 02:57:51 -0400
Date: Thu, 12 Jul 2001 09:57:37 +0300
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: Rob Landley <landley@webofficenow.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Hardware testing [was Re: VIA Southbridge bug (Was: Crash on boot (2.4.5))]
Message-ID: <20010712095737.A1503@niksula.cs.hut.fi>
In-Reply-To: <E15JIVD-0000Qc-00@the-village.bc.nu> <01071011282504.00634@localhost.localdomain> <20010711111159.A2026@suse.cz> <01071111051902.02490@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01071111051902.02490@localhost.localdomain>; from landley@webofficenow.com on Wed, Jul 11, 2001 at 11:05:19AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 11:05:19AM -0400, you [Rob Landley] claimed:
> On Wednesday 11 July 2001 05:11, Vojtech Pavlik wrote:
> 
> > I modified the 'memtest.c' little proggy (not the big memtest86, just a
> > little utility that runs under Linux), to use patterns and test size
> > that tests the L1 and then L2, and the error has shown after ten seconds
> > of running the test.
> 
> I don't suppose you still have that lying around somewhere? :)

I'm not sure if it's any good, but I have one at

http://v.iki.fi/~vherva/memburn.c

(It did find one bad memory case a while ago...)


-- v --

v@iki.fi
