Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263327AbTC2AWe>; Fri, 28 Mar 2003 19:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263328AbTC2AWe>; Fri, 28 Mar 2003 19:22:34 -0500
Received: from mail2.efi.com ([192.68.228.89]:45072 "HELO
	fcexgw02.efi.internal") by vger.kernel.org with SMTP
	id <S263327AbTC2AWd>; Fri, 28 Mar 2003 19:22:33 -0500
Message-ID: <3E84EA29.BEB27DB6@efi.com>
Date: Fri, 28 Mar 2003 16:34:49 -0800
From: Kallol Biswas <kallol.biswas@efi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: netchip's net2280 usb 2.0 device
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
     We have been using the net2280 chip (usb 2.0) as a usb target
printer device. We have been seeing data corruption problems
during a bulk out transfer when data is taken out the device
quite slow.  The corruption size is only 4 bytes suggesting
a device problem. Is anyone using this chip and has anyone
encountered similar problem?

Is there any other 2.0 usb chip that can be used as a target mode
device?


Kallol

