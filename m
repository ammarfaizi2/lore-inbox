Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265845AbUFIRq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265845AbUFIRq0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 13:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265847AbUFIRqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 13:46:25 -0400
Received: from host32.200-117-133.telecom.net.ar ([200.117.133.32]:53720 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S265845AbUFIRqY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 13:46:24 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.7-rc3-mm1
Date: Wed, 9 Jun 2004 14:46:33 -0300
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040609015001.31d249ca.akpm@osdl.org> <200406091335.15566.norberto+linux-kernel@bensa.ath.cx> <20040609170528.GR1444@holomorphy.com>
In-Reply-To: <20040609170528.GR1444@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406091446.33557.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> On Wed, Jun 09, 2004 at 01:35:15PM -0300, Norberto Bensa wrote:
> > drivers/pci/msi.c: In function `msi_address_init':
> > drivers/pci/msi.c:265: error: invalid operands to binary <<
> > make[2]: *** [drivers/pci/msi.o] Error 1
> > make[1]: *** [drivers/pci] Error 2
> > make: *** [drivers] Error 2
>
> The MSI writers have a lot to answer for. Could you test this?
>

I will tonight (8 hours from now.)

Thanks,
Norberto
