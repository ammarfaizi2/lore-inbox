Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbRFVHPi>; Fri, 22 Jun 2001 03:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265357AbRFVHPS>; Fri, 22 Jun 2001 03:15:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24840 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265355AbRFVHPK>; Fri, 22 Jun 2001 03:15:10 -0400
Subject: Re: ACPI or Advanced power ...
To: haiquy@yahoo.com (=?iso-8859-1?q?Steve=20Kieu?=)
Date: Fri, 22 Jun 2001 08:14:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (kernel)
In-Reply-To: <20010622050651.28491.qmail@web10401.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at Jun 22, 2001 03:06:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15DL98-0002zE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I need an advice, my machine is i810 chipset and using
> ACPI bios, but not sure which one i should use in the
> kernel config. Now I use APM with kernel kapm-idle .

If you have the option - use APM not ACPI. ACPI is larger, and right now
being experimental code - fairly buggy

