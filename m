Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263856AbRFDSno>; Mon, 4 Jun 2001 14:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263857AbRFDSnY>; Mon, 4 Jun 2001 14:43:24 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:8386 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263856AbRFDSnN>;
	Mon, 4 Jun 2001 14:43:13 -0400
Message-ID: <3B1BD6C0.9F54047E@mandrakesoft.com>
Date: Mon, 04 Jun 2001 14:43:12 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
Cc: jamal <hadi@cyberus.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <Pine.LNX.4.33.0106031401050.31050-100000@kenzo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bogdan Costescu wrote:
> 
> On Sat, 2 Jun 2001, jamal wrote:
> 
> > Still, the tx watchdogs are a good source of fault detection in the case
> > of non-availabilty of MII detection and even with the presence of MII.
> 
> Agreed. But my question was a bit different: is there any legit situation
> where Tx timeouts can happen in a row _without_ having a link loss ? In
> this situation, we'd have false positives...

yes

-- 
Jeff Garzik      | Echelon words of the day, from The Register:
Building 1024    | FRU Lebed HALO Spetznaz Al Amn al-Askari Glock 26 
MandrakeSoft     | Steak Knife Kill the President anarchy echelon
                 | nuclear assassinate Roswell Waco World Trade Center
