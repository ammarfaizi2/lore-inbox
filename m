Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUIIPj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUIIPj1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUIIPhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:37:38 -0400
Received: from open.hands.com ([195.224.53.39]:47574 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S265900AbUIIPgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:36:25 -0400
Date: Thu, 9 Sep 2004 16:47:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: tvrtko.ursulin@sophos.com
Cc: Erik Mouw <erik@harddisk-recovery.com>, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org
Subject: Re: GPL source code for Smart USB 56 modem (includes ALSA AC97  patch)
Message-ID: <20040909154736.GA9456@lkcl.net>
References: <OF7784085E.97108B7F-ON80256F0A.004D3045-80256F0A.004D5C17@green.sophos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7784085E.97108B7F-ON80256F0A.004D3045-80256F0A.004D5C17@green.sophos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 03:04:58PM +0100, tvrtko.ursulin@sophos.com wrote:
> >It's not a GPL driver, the kernel part contains a binary object file
> >(drivers/amrlibs.o) so I don't see how it can be included in the main
> >kernel tree. OTOH, at first glance only the PCI driver needs that
> >binary blob, the USB driver doesn't.
> 
> Droping in. :)
> 
> Kernel part is not required, slmodemd works with the snd-intel8x0m Alsa 
> driver. For me at least, and for the PCI version.
 
  ah! yes!  apt-cache show sl-modem-daemon.


	
