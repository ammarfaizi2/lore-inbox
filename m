Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313082AbSDDBk3>; Wed, 3 Apr 2002 20:40:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313083AbSDDBkT>; Wed, 3 Apr 2002 20:40:19 -0500
Received: from mail-src.takas.lt ([212.59.31.66]:7342 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S313082AbSDDBkD>;
	Wed, 3 Apr 2002 20:40:03 -0500
Date: Thu, 4 Apr 2002 03:32:41 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: Update on Promise 100TX2 + Serverworks IDE issues -- 2.2.20
To: "jim@rubylane.com" <jim@rubylane.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <20020403025820.4561.qmail@london.rubylane.com>
X-Mailer: Mahogany 0.64.2 'Sparc', compiled for Linux 2.4.18-rc4 i686
Message-ID: <ISPFE11vdnznMEmPzhz00000d07@mail.takas.lt>
X-OriginalArrivalTime: 04 Apr 2002 01:40:01.0961 (UTC) FILETIME=[A341D190:01C1DB79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Apr 2002 18:58:20 -0800 (PST) "jim@rubylane.com" <jim@rubylane.com> wrote:

j> This board does claim to support UDMA33 and Linux says the MB IDE
j> ports are in UDMA33 mode.  Works fine in just PIO mode.  Slower, but
j> at least it doesn't trash drives.

j> This board says:
j> 
j> ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
j> ServerWorks OSB4: chipset revision 0

IIRC downgrading DMA to MDMA2 should help.

Regards,
Nerijus

