Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280452AbRKSRny>; Mon, 19 Nov 2001 12:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280388AbRKSRng>; Mon, 19 Nov 2001 12:43:36 -0500
Received: from [195.66.192.167] ([195.66.192.167]:17422 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280452AbRKSRk7>; Mon, 19 Nov 2001 12:40:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: James A Sutherland <jas88@cam.ac.uk>,
        Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: x bit for dirs: misfeature?
Date: Mon, 19 Nov 2001 19:39:58 +0000
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200111191644.fAJGileU019108@pincoya.inf.utfsm.cl> <E165sA9-0006Nv-00@mauve.csi.cam.ac.uk>
In-Reply-To: <E165sA9-0006Nv-00@mauve.csi.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <01111919395802.07749@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 November 2001 17:24, James A Sutherland wrote:
> > > Yes, I see... All I can do is to add workarounds (ok,ok, 'support')
> > > to chmod and friends:
> > >
> > > chmod -R a+R dir  - sets r for files and rx for dirs
> >
> > X sets x for dirs, leaves files alone.
>
> Which sounds like exactly the behaviour the original poster wanted, AFAICS?

Yes, that sounds like the behaviour I want. But X flag does not do that. 
Sorry.

James, I don't like flame wars. Lets ask ourself: does this thread have any 
useful results? Unfortunately, not many.
Patches for chmod source would be better. Perhaps I should do that...

Let's refrain from "you're fool... go read manpage" type
discussions. Not productive.
--
vda
