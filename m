Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277729AbRJROue>; Thu, 18 Oct 2001 10:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277730AbRJROuY>; Thu, 18 Oct 2001 10:50:24 -0400
Received: from t2.redhat.com ([199.183.24.243]:16116 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S277729AbRJROuQ>; Thu, 18 Oct 2001 10:50:16 -0400
Message-ID: <3BCEEC49.90A402A0@redhat.com>
Date: Thu, 18 Oct 2001 15:50:49 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-4smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Donnelly <md@uklinux.net>, linux-kernel@vger.kernel.org
Subject: Re: Non-GPL modules
In-Reply-To: <Pine.LNX.3.95.1011018091343.32746A-100000@chaos.analogic.com> 
		<20011018090412.I22296@0xd6.org> <1003415874.4004.45.camel@inchgower>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Perhaps a less blunt tool could be used to encourage people to release
> GPL compatibly licensed code for their previously binary modules? I
> think you risk manufacturers withdrawing the support they have given by
> saying if they don't release their code we won't support anything to do
> with it.

This has been the case for a long time already (so long that I can't
remember
if/when it started:), so how did this change recently ? It didn't...
And vendors who supply binary only modules know already that they get to
do 
all the support as rules of the game. That didn't change either.

It's just that it's now easier for the people who get to handle
bugreports
to ask "which modules do you use" as first question if the tainted flag
is set,
instead of spending hours investigating a weird oops. 

Greetings,
   Arjan van de Ven
   (and yes, I do get a fair share of bugreports and really like to know
which 
    reports I should be suspicious of and ask for module lists etc)
