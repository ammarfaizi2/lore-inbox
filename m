Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319203AbSH2OGh>; Thu, 29 Aug 2002 10:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319210AbSH2OGh>; Thu, 29 Aug 2002 10:06:37 -0400
Received: from elin.scali.no ([62.70.89.10]:44294 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S319203AbSH2OGg>;
	Thu, 29 Aug 2002 10:06:36 -0400
Date: Thu, 29 Aug 2002 16:03:25 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@dpc-27.office.scali.no
To: Dominik Brodowski <devel@brodo.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Laptops with SpeedStep technology.
In-Reply-To: <20020829122407.B990@brodo.de>
Message-ID: <Pine.LNX.4.44.0208291557041.3923-100000@dpc-27.office.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2002, Dominik Brodowski wrote:

> Hi,
> 
> > Recently I got myself a Dell Inspiron 8200 with a Intel P4 Mobile wich has 
> > SpeedStep technology. With power plugged in, this processor runs at 1.6 
> > GHz and with battery only, 1.2 GHz. However I've found that the 
> > /proc/cpuinfo doesn't show this and I was wondering if there were some 
> > patches lying around before I began to look at this on my own.
> 
> Depending on the chipset, cpufreq for 2.5. ( http://www.brodo.de/cpufreq/ )
> should show the correct value in /proc/cpuinfo _and_ offer you the chance to
> control the processor speed. For 2.4., the functionality is offered, but
> /proc/cpuinfo stays the same (yet).
> 

Thanks Dominik, this was exactly what I was looking for. I will try it 
out.

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

