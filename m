Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319824AbSIMXWC>; Fri, 13 Sep 2002 19:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319825AbSIMXWB>; Fri, 13 Sep 2002 19:22:01 -0400
Received: from AMontpellier-205-1-13-198.abo.wanadoo.fr ([80.14.68.198]:39043
	"EHLO awak") by vger.kernel.org with ESMTP id <S319824AbSIMXWB> convert rfc822-to-8bit;
	Fri, 13 Sep 2002 19:22:01 -0400
Subject: Re: Good way to free as much memory as possible under 2.5.34?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0209131942330.1857-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0209131942330.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 14 Sep 2002 01:26:48 +0200
Message-Id: <1031959608.20072.23.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 14/09/2002 à 00:42, Rik van Riel a écrit :
> On 13 Sep 2002, Xavier Bestel wrote:
> > Le ven 13/09/2002 à 23:33, Rik van Riel a écrit :
> >
> > > I suspect only very few people will use swsuspend, so it should
> > > not be intrusive.
> >
> > I don't think so.
> 
> You think many people will use it, or you think swsuspend
> should be intrusive and have code in all other kernel
> subsystems ? ;)

I think people will use it. Either for laptops (when ACPI support will
match APM) or for desktop. Personnaly I'd use it for both if it were
functionnal.

