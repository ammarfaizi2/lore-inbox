Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSFXS4c>; Mon, 24 Jun 2002 14:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314885AbSFXS4b>; Mon, 24 Jun 2002 14:56:31 -0400
Received: from relay02.valueweb.net ([216.219.253.236]:26892 "EHLO
	relay02.valueweb.net") by vger.kernel.org with ESMTP
	id <S314243AbSFXS4b>; Mon, 24 Jun 2002 14:56:31 -0400
Message-ID: <3D176B79.774DD1B7@opersys.com>
Date: Mon, 24 Jun 2002 14:56:57 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: "Salvatore D'Angelo" <dangelo.sasaman@tiscalinet.it>
CC: Matti Aarnio <matti.aarnio@zmailer.org>,
       Chris McDonald <chris@cs.uwa.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <3D16DE83.3060409@tiscalinet.it> <200206240934.g5O9YL524660@budgie.cs.uwa.edu.au> <3D16F252.90309@tiscalinet.it> <20020624154620.P19520@mea-ext.zmailer.org> <3D172543.9070709@tiscalinet.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Salvatore D'Angelo wrote:
> On 2000000 call -> 189 times I found the problem (0.00945%)
> On 20000000 call ->1956 found I found the problem (0.00978%)
...
> But do you think that this behaviour is normal?

This has already been discussed on the LKML. Here's the thread:
http://marc.theaimsgroup.com/?t=102348161100006&r=1&w=2

I posted the following message on this issue:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102348249521519&w=2

As I had said earlier, I've seen this happen before on both i386 and
PPC machines.

Cheers,

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
