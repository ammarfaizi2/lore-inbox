Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282898AbRK0K05>; Tue, 27 Nov 2001 05:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282899AbRK0K0r>; Tue, 27 Nov 2001 05:26:47 -0500
Received: from gateway-2.hyperlink.com ([213.52.152.2]:47373 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S282898AbRK0K0a>; Tue, 27 Nov 2001 05:26:30 -0500
Message-ID: <3511.10.119.8.1.1006856832.squirrel@extranet.jtrix.com>
Date: Tue, 27 Nov 2001 10:27:12 -0000 (GMT)
Subject: "spurious 8259A interrupt: IRQ7"
From: "Martin A. Brooks" <martin@jtrix.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get this with 2.4.16 vanilla, though. IRQ 7 appears to be unassigned
according to /proc/pci.

Machine is a 1ghz Athlon on a VIA VT82C686 mobo and a DEC 21140 NIC.

Any pointers appreciated.

Regards

Martin A. Brooks.


