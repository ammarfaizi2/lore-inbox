Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRJVPQr>; Mon, 22 Oct 2001 11:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275790AbRJVPQc>; Mon, 22 Oct 2001 11:16:32 -0400
Received: from doorbell.lineo.com ([204.246.147.253]:33472 "EHLO
	thor.lineo.com") by vger.kernel.org with ESMTP id <S274774AbRJVPQE>;
	Mon, 22 Oct 2001 11:16:04 -0400
Message-ID: <3BD438ED.360D0007@lineo.com>
Date: Mon, 22 Oct 2001 09:19:09 -0600
From: Tim Bird <tbird@lineo.com>
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules - legal nonsense
In-Reply-To: <E15v4Dz-0002VM-00@the-village.bc.nu> <3BD1F5CC.20BF3F20@candelatech.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> 
> Alan Cox wrote:
> >
> > > What prevents the author of a non-GPL module who needs access to a
> > > GPL-only symbol from writing a small GPLed module which imports the
> > > GPL-only symbol (this is allowed, because the small module is GPL),
> > > and exports a basically identical symbol without the GPL-only
> > > restriction?
> >
> > The fact that it ends up GPL'd to be linked (legal derivative work sense)
> > to the GPL'd code so you can link it to either but not both at the same time
> 
> If you own the copyright to the small shim GPL piece, can anyone else
> take legal action on your part?  If not, then all you have to do is not
> sue yourself for the double linkage and no one else can sue you either....

I keep hearing this type of reasoning.  It flat-out doesn't work
this way in the legal system.  This is similar to arguing that
you didn't really stab someone if you threw the knife instead
of holding it. ("But your honor, once the knife left my hand
it really wasn't under my control...")

If your actions bring about the result, whether
directly or indirectly, you are legally liable for the
consequences.
____________________________________________________________
Tim Bird                                  Lineo, Inc.
Senior VP, Research                       390 South 400 West
tbird@lineo.com                           Lindon, UT 84042
