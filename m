Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131429AbRCKOnp>; Sun, 11 Mar 2001 09:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131436AbRCKOnf>; Sun, 11 Mar 2001 09:43:35 -0500
Received: from linuxcare.com.au ([203.29.91.49]:34828 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S131429AbRCKOnP>; Sun, 11 Mar 2001 09:43:15 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Mon, 12 Mar 2001 01:38:27 +1100
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: allow notsc option for buggy cpus
Message-ID: <20010312013827.B5439@linuxcare.com>
In-Reply-To: <20010310115828.A7514@linuxcare.com> <E14bY2D-00063q-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <E14bY2D-00063q-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Mar 10, 2001 at 01:19:03AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Intel are being remarkably reluctant on the documentation front.  We have
> the AMD speed change docs, but the intel ones (chipset not cpu based
> primarily) don't seem to be publically available. In fact the 815M manual
> looks like someone quite pointedly went through and removed the relevant
> material before publication

But is there a reason we don't allow the notsc option at all on
certain chipsets? Who would complain if I removed the CONFIG_X86_TSC
option from the CONFIG_M686 definition or even got rid of it completely?

Anton
