Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbVKCP5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbVKCP5O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbVKCP5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:57:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:30136 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030358AbVKCP5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:57:14 -0500
Subject: Re: Parallel ATA with libata status with the patches I'm working on
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
In-Reply-To: <58cb370e0511030748r1cd78522o6b33d68df5a77098@mail.gmail.com>
References: <1131029686.18848.48.camel@localhost.localdomain>
	 <20051103144830.GF28038@flint.arm.linux.org.uk>
	 <58cb370e0511030702hb06a5f3qc2dfe465ee1d784c@mail.gmail.com>
	 <20051103.072810.129576574.davem@davemloft.net>
	 <58cb370e0511030748r1cd78522o6b33d68df5a77098@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Nov 2005 16:27:07 +0000
Message-Id: <1131035227.18848.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-03 at 16:48 +0100, Bartlomiej Zolnierkiewicz wrote:
> I'm worried about crap being pushed into libata, that's all.

I wouldn't be too worried. Jeff Garzik is quite fussy about what goes in
and that it gets designed the right way. Various things aren't currently
merged because Jeff wants them redone better - such as the ISA legacy
support.

Alan
