Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312461AbSCZO2Q>; Tue, 26 Mar 2002 09:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312341AbSCZO14>; Tue, 26 Mar 2002 09:27:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30483 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312334AbSCZO1w>; Tue, 26 Mar 2002 09:27:52 -0500
Subject: Re: is the AD1885 Audio Codec suppored by the 2.4.x Kernel?
To: reg@dwf.com
Date: Tue, 26 Mar 2002 14:19:27 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200203260320.g2Q3KvcY008282@orion.dwf.com> from "reg@dwf.com" at Mar 25, 2002 08:20:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16prnL-000395-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The subject line says it all:
> 	Is the AD1885 Audio Codec supported by the 2.4.x kernel?

Thats an AC97 chip (ie a D/A convertor with bells on). What matters is what
actual sound chip it is wired to
