Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSL3QAG>; Mon, 30 Dec 2002 11:00:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbSL3QAG>; Mon, 30 Dec 2002 11:00:06 -0500
Received: from mail.ithnet.com ([217.64.64.8]:2322 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266989AbSL3QAF>;
	Mon, 30 Dec 2002 11:00:05 -0500
Date: Mon, 30 Dec 2002 17:08:22 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: APIC with SIS
Message-Id: <20021230170822.1b79ebb3.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

can any kind soul tell me the chances for implementation of:

<6>PCI: Using IRQ router SIS [1039/0008] at 00:01.0
<6>SiS pirq: advanced IDE/ACPI/DAQ mapping not yet implemented

in 2.4 ?
This message shows up if enabling APIC on boards with SIS630 chipset.

-- 
Regards,
Stephan
