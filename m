Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131437AbRCKOqp>; Sun, 11 Mar 2001 09:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131440AbRCKOqg>; Sun, 11 Mar 2001 09:46:36 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24332 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131437AbRCKOqc>; Sun, 11 Mar 2001 09:46:32 -0500
Subject: Re: [PATCH]: allow notsc option for buggy cpus
To: anton@linuxcare.com.au (Anton Blanchard)
Date: Sun, 11 Mar 2001 14:49:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010312013827.B5439@linuxcare.com> from "Anton Blanchard" at Mar 12, 2001 01:38:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14c79e-00009A-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But is there a reason we don't allow the notsc option at all on
> certain chipsets? Who would complain if I removed the CONFIG_X86_TSC
> option from the CONFIG_M686 definition or even got rid of it completely?

I believe someone had performance reasons. I'm sceptical and I'd tend to agree
with your view. Bug Ingo see what he says

