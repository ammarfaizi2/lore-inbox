Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319169AbSH2KWC>; Thu, 29 Aug 2002 06:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319170AbSH2KWC>; Thu, 29 Aug 2002 06:22:02 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:33824 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S319169AbSH2KWB>; Thu, 29 Aug 2002 06:22:01 -0400
Date: Thu, 29 Aug 2002 12:24:07 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Steffen Persvold <sp@scali.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Laptops with SpeedStep technology.
Message-ID: <20020829122407.B990@brodo.de>
References: <Pine.LNX.4.44.0208291004550.1952-100000@sp-laptop.isdn.scali.no> <19221.1030616464@www25.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <19221.1030616464@www25.gmx.net>; from sp@scali.com on Thu, Aug 29, 2002 at 12:21:04PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Recently I got myself a Dell Inspiron 8200 with a Intel P4 Mobile wich has 
> SpeedStep technology. With power plugged in, this processor runs at 1.6 
> GHz and with battery only, 1.2 GHz. However I've found that the 
> /proc/cpuinfo doesn't show this and I was wondering if there were some 
> patches lying around before I began to look at this on my own.

Depending on the chipset, cpufreq for 2.5. ( http://www.brodo.de/cpufreq/ )
should show the correct value in /proc/cpuinfo _and_ offer you the chance to
control the processor speed. For 2.4., the functionality is offered, but
/proc/cpuinfo stays the same (yet).

Dominik
