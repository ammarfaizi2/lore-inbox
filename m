Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290720AbSAYQsD>; Fri, 25 Jan 2002 11:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290721AbSAYQrx>; Fri, 25 Jan 2002 11:47:53 -0500
Received: from ns.ithnet.com ([217.64.64.10]:40977 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S290720AbSAYQrl>;
	Fri, 25 Jan 2002 11:47:41 -0500
Date: Fri, 25 Jan 2002 17:47:30 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Marcel Kunath" <kunathma@pilot.msu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Machine Check Exception ?
Message-Id: <20020125174730.4e1e90d0.skraw@ithnet.com>
In-Reply-To: <200201251237.g0PCbOR17328@pilot05.cl.msu.edu>
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com>
	<200201251237.g0PCbOR17328@pilot05.cl.msu.edu>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002 07:37:24 -0500 (EST)
"Marcel Kunath" <kunathma@pilot.msu.edu> wrote:

> Whats the mobo?

Ok,here we go:

diehard:~ # lspci 
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
00:04.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
00:04.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
00:09.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR) 53c810 (rev 23)
00:0a.0 PCI bridge: Intel Corporation 80960RP [i960 RP Microprocessor/Bridge] (rev 05)
00:0a.1 RAID bus controller: Mylex Corporation DAC960PX (rev 05)
00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
01:00.0 VGA compatible controller: S3 Inc. 86c368 [Trio 3D/2X] (rev 02)

Regards,
Stephan


