Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264323AbRFMCtH>; Tue, 12 Jun 2001 22:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264346AbRFMCs6>; Tue, 12 Jun 2001 22:48:58 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:40860 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S264334AbRFMCss>;
	Tue, 12 Jun 2001 22:48:48 -0400
Message-ID: <3B26D47E.DD0D3EB9@mandrakesoft.com>
Date: Tue, 12 Jun 2001 22:48:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.6-pre3
In-Reply-To: <26832.992400011@ocs4.ocs-net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Tue, 12 Jun 2001 18:42:45 -0700 (PDT),
> Linus Torvalds <torvalds@transmeta.com> wrote:
> >-pre3:
> > - Jeff Garzik: network driver updates
> 
> tulip_core.c:1756: warning: initialization from incompatible pointer type
> tulip_core.c:1757: warning: initialization from incompatible pointer type

There are no network driver updates, including no tulip updates

The PCI API changed, there is breakage and cleanup is needed

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
