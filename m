Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311368AbSCSOpf>; Tue, 19 Mar 2002 09:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311366AbSCSOpQ>; Tue, 19 Mar 2002 09:45:16 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62730 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S311368AbSCSOpK>; Tue, 19 Mar 2002 09:45:10 -0500
Subject: Re: Config Parameters for Tyan 2462?
To: m.knoblauch@teraport.de
Date: Tue, 19 Mar 2002 15:01:19 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <3C97498C.329A0A4F@TeraPort.de> from "Martin Knoblauch" at Mar 19, 2002 03:22:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16nL71-0007ub-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  simple question: what config parameters should one use for Dual-Athlon,
> Tyan2462 SMP Kernel based on 2.4.18-ac3. No additional PCI cards. One or
> two IDE disks, 2 GB memory. Which of options are essential, which are
> deadly?

You should not need to do anything special. Make sure you include AMD IDE
support for UDMA IDE performance. 
