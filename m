Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262661AbSJBWkb>; Wed, 2 Oct 2002 18:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbSJBWka>; Wed, 2 Oct 2002 18:40:30 -0400
Received: from [66.70.28.20] ([66.70.28.20]:34564 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S262661AbSJBWka>; Wed, 2 Oct 2002 18:40:30 -0400
Date: Thu, 3 Oct 2002 00:38:01 +0200
From: DervishD <raul@pleyades.net>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: undertow <undertow@dexcom.org>, linux-kernel@vger.kernel.org
Subject: Re: possible bug
Message-ID: <20021002223801.GA6760@DervishD>
References: <1033487088.2369.6.camel@aenima> <20021001163743.GA275@DervishD> <200210022035.g92KZkp31963@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200210022035.g92KZkp31963@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Denis :)

> > you're trying to 'kill -9' is stuck in 'D' state (or any other
> > uninterruptible state), so it's not a kernel bug ;) If this is not
> How come? Process stuck in 'D' state *is* a kernel bug

    Yes if it is stuck in that state forever, but I've suffered
processes stuck in 'D' state due to, for example, my CD recorder
frozen... It can last more than 600 seconds, and it's not a kernel
bug, just a 'long-lasting' transient state ;)

    Anyway, last time I had a process stuck in 'D' state was back in
2.2 kernel, more than a year ago.

    Raúl
