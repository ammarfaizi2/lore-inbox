Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263022AbRFDXYG>; Mon, 4 Jun 2001 19:24:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbRFDXXz>; Mon, 4 Jun 2001 19:23:55 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5061 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S263022AbRFDXXr>;
	Mon, 4 Jun 2001 19:23:47 -0400
Message-ID: <3B1C1872.8D8F1529@mandrakesoft.com>
Date: Mon, 04 Jun 2001 19:23:30 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: bjornw@axis.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: Missing cache flush.
In-Reply-To: <13942.991696607@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> I was pointed at Documentation/DMA-mapping.txt but that doesn't seem very
> helpful - it's very PCI-specific, and a quick perusal of pci_dma_sync() on
> i386 shows that it doesn't do what's required anyway.

What should it do on i386?  mb()?

-- 
Jeff Garzik      | Echelon words of the day, from The Register:
Building 1024    | FRU Lebed HALO Spetznaz Al Amn al-Askari Glock 26 
MandrakeSoft     | Steak Knife Kill the President anarchy echelon
                 | nuclear assassinate Roswell Waco World Trade Center
