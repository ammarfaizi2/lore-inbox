Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285153AbRLXQiH>; Mon, 24 Dec 2001 11:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285151AbRLXQh5>; Mon, 24 Dec 2001 11:37:57 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:58372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285154AbRLXQho>; Mon, 24 Dec 2001 11:37:44 -0500
Subject: Re: IDE CDROM locks the system hard on media error
To: stano@meduna.org (Stanislav Meduna)
Date: Mon, 24 Dec 2001 16:47:56 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200112240930.fBO9U9b01874@meduna.org> from "Stanislav Meduna" at Dec 24, 2001 10:30:09 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IYGb-0004Uk-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am using vanilla 2.4.17, hdc=ide-scsi, my drive is Mitsumi CR-4804TE,
> motherboard is Abit BP6 SMP, Intel PIIX4 IDE controller,

I've seen a few similar reports of this back to about 2.4.10 or so, maybe
earlier even. Right now I don't think anyone knows what is up
