Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276786AbRJBXRa>; Tue, 2 Oct 2001 19:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276785AbRJBXRU>; Tue, 2 Oct 2001 19:17:20 -0400
Received: from hermes.toad.net ([162.33.130.251]:39582 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S276784AbRJBXRN>;
	Tue, 2 Oct 2001 19:17:13 -0400
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
To: linux-kernel@vger.kernel.org
Date: Tue, 2 Oct 2001 19:17:09 -0400 (EDT)
X-Mailer: ELM [version 2.4ME+ PL73 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20011002231709.97F1610E7@thanatos.toad.net>
From: jdthood@home.dhs.org (Thomas Hood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, the funny thing is, the same kernel doesn't boot on a Dell Inspiron 
> laptop either, if PNP is enabled -- and the oops is the same. So it's not 
> just Sony...
> 
> 2.4.9-ac10 has no such issues on the same laptop, btw.
> 
> Ion

Thanks for reporting this.  Please try 2.4.10-ac3.  If your
kernel won't boot, try booting with the "nobioscurrpnp" option.

-- 
Thomas Hood
(Don't reply to the From: address but to jdthood_AT_yahoo.co.uk)
