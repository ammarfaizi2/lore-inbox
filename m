Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274141AbRISTRY>; Wed, 19 Sep 2001 15:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274139AbRISTRP>; Wed, 19 Sep 2001 15:17:15 -0400
Received: from t2.redhat.com ([199.183.24.243]:49402 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274141AbRISTRB>; Wed, 19 Sep 2001 15:17:01 -0400
Message-ID: <3BA8EF40.8D70612D@redhat.com>
Date: Wed, 19 Sep 2001 20:17:20 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <3BA8EA04.E55BAA02@redhat.com> <Pine.GSO.4.21.0109191559120.12342-100000@jacui>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Jung Drebes wrote:
> 
> On Wed, 19 Sep 2001, Arjan van de Ven wrote:
> 
> > Ok but that part is simple:
> >
> > run
> >
> > http://www.fenrus.demon.nl/athlon.c
> 
> I will run it tonight, and report the results later. Any recommendation,
> like running in single user mode, or something like that?

Nah don't bother, just make sure your machine is mostly idle.

The performance difference between the clasical code and the "fast" 
code should be in the 2x order; running the test a few times
should be a good enough test.
