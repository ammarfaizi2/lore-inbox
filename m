Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRHRNAO>; Sat, 18 Aug 2001 09:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270154AbRHRNAF>; Sat, 18 Aug 2001 09:00:05 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50949 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270134AbRHRM7z>; Sat, 18 Aug 2001 08:59:55 -0400
Subject: Re: Kernel 2.4.9 locks up solidly with USB and SMP
To: andystewart@mediaone.net (Andy Stewart)
Date: Sat, 18 Aug 2001 13:12:59 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, andystewart@mediaone.net
In-Reply-To: <01081800562800.08460@tux> from "Andy Stewart" at Aug 18, 2001 12:56:27 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Y4yJ-0000p0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SMP without USB seems to work properly.  USB in uniprocessor mode is also 
> working properly.
> 
> I have usbcore and usb-uhci loaded as modules.

Use the uhci module instead and it ought to be better

