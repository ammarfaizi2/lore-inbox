Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314283AbSEBIuH>; Thu, 2 May 2002 04:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSEBIuG>; Thu, 2 May 2002 04:50:06 -0400
Received: from AMontpellier-201-1-4-206.abo.wanadoo.fr ([217.128.205.206]:46521
	"EHLO awak") by vger.kernel.org with ESMTP id <S314283AbSEBIuF> convert rfc822-to-8bit;
	Thu, 2 May 2002 04:50:05 -0400
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while
	reading damadged files
From: Xavier Bestel <xavier.bestel@free.fr>
To: Stephen Samuel <samuel@bcgreen.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Bill Davidsen <davidsen@tmr.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD0F846.3070605@bcgreen.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 02 May 2002 10:49:50 +0200
Message-Id: <1020329390.2595.9.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 02/05/2002 à 10:26, Stephen Samuel a écrit :
> I ran a similar type of test on a 2.4.9.31 (redhat 7.1 ) kernel.
> With the CD on HDD, I could read off of HDA just peachy while
> the system was choking on a scratched (aol) cd.

The "system grinding to a halt" happens to me too, when *ripping*
scratched cds. Note that it's when using *userspace* access to the block
device, with e.g. cdparanoia or grip (or dvd ripping tools).

My DVD drive is on a VT82C693A/694x (ABit VP6).

