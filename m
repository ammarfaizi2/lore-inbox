Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSEAH5B>; Wed, 1 May 2002 03:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSEAH5A>; Wed, 1 May 2002 03:57:00 -0400
Received: from AMontpellier-201-1-4-206.abo.wanadoo.fr ([217.128.205.206]:57094
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S315334AbSEAH47> convert rfc822-to-8bit; Wed, 1 May 2002 03:56:59 -0400
Subject: Re: ide <-> via VT82C693A/694x problems?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Erik Steffl <steffl@bigfoot.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CCF4BFD.6C7F67EB@bigfoot.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.4 
Date: 01 May 2002 09:56:34 +0200
Message-Id: <1020239797.10097.68.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 01/05/2002 à 03:59, Erik Steffl a écrit :
>   the MB uses via chips so I included via82cxxx driver (as a module). is
> that correct?
> 
>   however, I just checked and via82cxxx is NOT loaded. What do I need to
> do to make ide driver is using via82cxxx module?
> 
>   I have ide driver compiled in (booting from ide hd), does via82cxxx
> have to be compiled in?

You mean the ide module is on the ide drive ? And you want it to be
loaded before any ide access ?


