Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263333AbRFNPeE>; Thu, 14 Jun 2001 11:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263211AbRFNPdo>; Thu, 14 Jun 2001 11:33:44 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:45199 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263217AbRFNPdc>;
	Thu, 14 Jun 2001 11:33:32 -0400
Message-ID: <3B28D949.8C56C963@mandrakesoft.com>
Date: Thu, 14 Jun 2001 11:33:29 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: Tom Gall <tom_gall@vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
			<3B28C6C1.3477493F@mandrakesoft.com>
			<15144.51504.8399.395200@pizda.ninka.net>
			<3B28CB1A.E8226801@mandrakesoft.com> <15144.52565.566355.291642@pizda.ninka.net> <3B28D870.179876B1@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Pretty much any arch with a PCI slot can have multiple domains, now that
> hotplug controllers are out and about.  So it seems a generic enough
> concept to me...

Um, correction:  that is assuming a certain implementation...  you can
certainly implement a hotplug controller as another PCI-PCI bridge,
AFAICS, too.

-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
