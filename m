Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSEVKmx>; Wed, 22 May 2002 06:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSEVKmw>; Wed, 22 May 2002 06:42:52 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:7148
	"EHLO awak") by vger.kernel.org with ESMTP id <S290289AbSEVKmv> convert rfc822-to-8bit;
	Wed, 22 May 2002 06:42:51 -0400
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
From: Xavier Bestel <xavier.bestel@free.fr>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <3CEB5EF4.604@evision-ventures.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.5 
Date: 22 May 2002 12:42:28 +0200
Message-Id: <1022064150.16864.5.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer 22/05/2002 à 11:03, Martin Dalecki a écrit :
> Uz.ytkownik Xavier Bestel napisa?:
> 
> > Compressing pages will speed up the process, and doing it on the fly
> 
> Did you ever in you life tar czvf ./some_dir and have a look at top?!

I just tried to verify; on my laptop (Armada 1700 w/ pII 300 & IBM
Travelstar) I have roughly 20% idle CPU during tar zcf. Laptop HDs are
slow.


