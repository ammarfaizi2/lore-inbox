Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274520AbRJTWIV>; Sat, 20 Oct 2001 18:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274681AbRJTWIM>; Sat, 20 Oct 2001 18:08:12 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:14491 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274520AbRJTWH6>;
	Sat, 20 Oct 2001 18:07:58 -0400
Message-ID: <3BD1F5CC.20BF3F20@candelatech.com>
Date: Sat, 20 Oct 2001 15:08:12 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jan Niehusmann <jan@gondor.com>, linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules
In-Reply-To: <E15v4Dz-0002VM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > What prevents the author of a non-GPL module who needs access to a
> > GPL-only symbol from writing a small GPLed module which imports the
> > GPL-only symbol (this is allowed, because the small module is GPL),
> > and exports a basically identical symbol without the GPL-only
> > restriction?
> 
> The fact that it ends up GPL'd to be linked (legal derivative work sense)
> to the GPL'd code so you can link it to either but not both at the same time

If you own the copyright to the small shim GPL piece, can anyone else
take legal action on your part?  If not, then all you have to do is not
sue yourself for the double linkage and no one else can sue you either....

Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
