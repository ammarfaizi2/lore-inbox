Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTBTRk1>; Thu, 20 Feb 2003 12:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbTBTRk1>; Thu, 20 Feb 2003 12:40:27 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:12251 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S266186AbTBTRk0>;
	Thu, 20 Feb 2003 12:40:26 -0500
Subject: Re: SMP-Linux
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: jamesbuch@iprimus.com.au
Cc: "John W. M. Stevens" <john@betelgeuse.us>, linux-kernel@vger.kernel.org
In-Reply-To: <200302211645.07356.jamesbuch@iprimus.com.au>
References: <001501c2d11a$3ad9c3a0$59951ad3@windows>
	 <005601c2d11f$bfe5e060$59951ad3@windows>
	 <1045762740.12534.110.camel@zion.wanadoo.fr>
	 <200302211645.07356.jamesbuch@iprimus.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045763580.12533.114.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Feb 2003 18:53:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 06:45, James Buchanan wrote:
> > Well... how do you think linux actually works ? Did you bother
> > _reading_ the code before proposing to do something that is
> > basically already there ? :)
> 
> Ah!  No, not really.  It is not a complete HAL.  And no, I didn't read 
> all the source, I am not sure if anyone can do that very 
> successfully.  I did know there was SMP, yup.  Seen it all...
> 
> The sources are very hard to read!  Poor design/no design, lack of 
> documentation, shit documentation from programmers that can't spell, 
> etc.  ;-)

Hrm... In your previous mail, you talked about doing a thin layer
that gives efficiency. That's exactly what it is.

Honestly, you can find crappy code in linux here or there, that's
not the problem. I doubt you'll be able to backup your claims very
long regarding this specific one which is SMP, especially in 2.5
kernels.

But feel free to prove me wrong by actually doing something, then
showing us numbers !

Ben.

