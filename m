Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSGCP0D>; Wed, 3 Jul 2002 11:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSGCP0C>; Wed, 3 Jul 2002 11:26:02 -0400
Received: from ns.suse.de ([213.95.15.193]:60178 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317025AbSGCP0C>;
	Wed, 3 Jul 2002 11:26:02 -0400
Date: Wed, 3 Jul 2002 17:28:32 +0200
From: Dave Jones <davej@suse.de>
To: Nick Evgeniev <nick@octet.spb.ru>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work
Message-ID: <20020703172832.A8934@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nick Evgeniev <nick@octet.spb.ru>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <E17O821-0007we-00@the-village.bc.nu> <000801c220f5$8176fb50$15cf69c2@nick>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000801c220f5$8176fb50$15cf69c2@nick>; from nick@octet.spb.ru on Mon, Jul 01, 2002 at 03:49:43PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 03:49:43PM +0400, Nick Evgeniev wrote:

 >     Why are you so assure? It's "msi 845e Max" with LAN on-board mb with
 > _latest_ BIOS installed....
 > Just FYI 2.4.18 was even unable to run eepro100 driver on it while intels
 > e100 driver was working perfectly.

Could this be related to the pci id clash I pointed out last week?
That id was for an intel IDE device iirc.

(Recap: Two id's don't tally between 2.4/2.5)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
