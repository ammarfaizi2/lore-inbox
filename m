Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286806AbRL1Jw4>; Fri, 28 Dec 2001 04:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286803AbRL1Jwq>; Fri, 28 Dec 2001 04:52:46 -0500
Received: from web1.oops-gmbh.de ([212.36.232.3]:52242 "EHLO
	sabine.freising-pop.de") by vger.kernel.org with ESMTP
	id <S286795AbRL1Jwb>; Fri, 28 Dec 2001 04:52:31 -0500
Message-ID: <3C2C3F55.3BA4A0C3@sirius-cafe.de>
Date: Fri, 28 Dec 2001 10:45:57 +0100
From: Martin Knoblauch <knobi@sirius-cafe.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-), Freising
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Scheduler issue 1, RT tasks ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [RFC] Scheduler issue 1, RT tasks ...
> 
> >
> > Right, that was my question. George says, in your words, "for better
> 
> > standards compliancy ..." and I want to know why you guys think
> that.
> 
> The thought was that if someone need RT tasks he probably need a very
> low
> latency and so the idea that by applying global preemption decisions
> would
> lead to a better compliancy. But i'll be happy to ear that this is
> false
> anyway ...
> 

 without wanting to start a RT flame-fest, what do people really want
when they talk about RT in this [Linux] context:

- very low latency
- deterministic latency ("never to exceed")
- both
- something completely different

Thanks
Martin
-- 
+-----------------------------------------------------+
|Martin Knoblauch                                     |
|-----------------------------------------------------|
|http://www.knobisoft.de/cats                         |
|-----------------------------------------------------|
|e-mail: knobi@knobisoft.de                           |
+-----------------------------------------------------+
