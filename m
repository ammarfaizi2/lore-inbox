Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318762AbSHWLEu>; Fri, 23 Aug 2002 07:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318764AbSHWLEt>; Fri, 23 Aug 2002 07:04:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22545 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318762AbSHWLEt>; Fri, 23 Aug 2002 07:04:49 -0400
Date: Fri, 23 Aug 2002 12:08:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Jeff Garzik <jgarzik@mandrakesoft.com>,
       "'Linux Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: IDE-flash device and hard disk on same controller
Message-ID: <20020823120851.C20963@flint.arm.linux.org.uk>
References: <Pine.LNX.4.10.10208222016350.13077-100000@master.linux-ide.org> <Pine.GSO.4.21.0208231249250.15704-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0208231249250.15704-100000@vervain.sonytel.be>; from geert@linux-m68k.org on Fri, Aug 23, 2002 at 12:50:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 12:50:49PM +0200, Geert Uytterhoeven wrote:
> On Thu, 22 Aug 2002, Andre Hedrick wrote:
> > Oh and it is only useful for borken things like LINBIOS and other
> > braindead systems like ARM that violate the 31 second rule of POST.
> 
> Is the 31 second rule defined for the PC or for IDE?

It's in the ATA specs.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

