Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136082AbRDVMpP>; Sun, 22 Apr 2001 08:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136080AbRDVMoz>; Sun, 22 Apr 2001 08:44:55 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:41487 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136079AbRDVMow>; Sun, 22 Apr 2001 08:44:52 -0400
Subject: Re: [2.4.3ac11] clock timer configuration lost - probably a VIA686a motherboard
To: andihartmann@freenet.de (Andreas Hartmann)
Date: Sun, 22 Apr 2001 13:46:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01042214101400.15273@athlon> from "Andreas Hartmann" at Apr 22, 2001 02:10:14 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rJGD-0005lO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I got a lot of messages while continuous writing / reading datas from one a 
> harddisk to another harddisk (both at 1. ide-channel) during backup with 
> rsync. Both harddisks use udma4. The data-stream was between 0,5 MB/s and 
> 20MB/s.
> I never got these messages before and after the backup finished I couldn't 
> see them anymore.

Thy do trigger to easily. Im still investigating that
