Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270314AbRH3IUu>; Thu, 30 Aug 2001 04:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270319AbRH3IUk>; Thu, 30 Aug 2001 04:20:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:21006 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270314AbRH3IU3>; Thu, 30 Aug 2001 04:20:29 -0400
Subject: Re: Multithreaded core dumps
To: kmacy@netapp.com (Kip Macy)
Date: Thu, 30 Aug 2001 09:24:03 +0100 (BST)
Cc: efeingold@mn.rr.com (Elan Feingold), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.10.10108292242080.10391-100000@cranford-fe.eng.netapp.com> from "Kip Macy" at Aug 29, 2001 10:50:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cN7L-0000gX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am inclined to believe that that is the case. Unfortunately, I have no
> advice to give - but I am writing because I think that it would be neat if
> you have the time and the inclination for you to document your findings as
> you progress and put them on the web. 

The 2.4-ac tree supports dumping core.$pid for the threads that actually
died
