Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRHWM6i>; Thu, 23 Aug 2001 08:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272256AbRHWM62>; Thu, 23 Aug 2001 08:58:28 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44806 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272253AbRHWM6I>; Thu, 23 Aug 2001 08:58:08 -0400
Subject: Re: yenta_socket hangs sager laptop in kernel 2.4.6-> PNPBIOS life saver
To: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 23 Aug 2001 14:00:35 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        Gunther.Mayer@t-online.de (Gunther Mayer),
        kuznet@ms2.inr.ac.ru (Alexey Kuznetsov), alan@redhat.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20010823111122.B1143@bytesex.org> from "Gerd Knorr" at Aug 23, 2001 11:11:22 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Zu68-0003nE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Before PnPBIOS can go mainstream we'd have to generate a detailed list
> > of buggy bios signatures
> 
> Why?  It shouldn't harm if disabled, so IMHO it should be fine when
> flagged "experimental" and with a warning label about broken bioses in
> Configure.help ...

We will see what happens. Certainly if someone wants to provide pnpbios code
patches for -ac that grab and reserve the motherboard resources from the PCI
code go ahead.
