Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162256AbWKPENF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162256AbWKPENF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 23:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162272AbWKPENF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 23:13:05 -0500
Received: from gate.crashing.org ([63.228.1.57]:35045 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1162256AbWKPENC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 23:13:02 -0500
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
In-Reply-To: <455BDA1D.5090409@garzik.org>
References: <455A938A.4060002@garzik.org>
	 <20061114.201549.69019823.davem@davemloft.net> <455A9664.50404@garzik.org>
	 <20061114.202814.70218466.davem@davemloft.net>
	 <1163643937.5940.342.camel@localhost.localdomain>
	 <455BDA1D.5090409@garzik.org>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 15:12:21 +1100
Message-Id: <1163650341.5940.361.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> We are referring to the standard PCI 2.2 bit, PCI_COMMAND_INTX_DISABLE.

Yeah, I figured it, I somewhat forgot about it ... it got introduced in
2.3 though, no ?

Cheers,
Ben.


