Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129999AbQLBTrd>; Sat, 2 Dec 2000 14:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbQLBTrY>; Sat, 2 Dec 2000 14:47:24 -0500
Received: from colorfullife.com ([216.156.138.34]:15882 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S129999AbQLBTrP>;
	Sat, 2 Dec 2000 14:47:15 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11: hangs while "Probing PCI hardware" for Sony Vaio C1VE (Crusoe)
Message-ID: <975784798.3a294b5eb738e@ssl.local>
Date: Sat, 02 Dec 2000 20:19:58 +0100 (CET)
From: Wolfgang Spraul <wspraul@q-ag.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
X-Originating-IP: 172.26.20.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PhoenixBIOS, Sony Vaio C1VE

I did some printk() debugging, but the kernel hangs at various places in
pci_setup_device(), mostly in pci_read_bases().

I will assist in debugging if needed.
Regards,
Wolfgang
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
