Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVAROPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVAROPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 09:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVAROPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 09:15:35 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:48607 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S261302AbVAROPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 09:15:18 -0500
Date: Tue, 18 Jan 2005 15:15:15 +0100
From: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4: "access beyond end of device" after ext2 mount
Message-ID: <20050118141515.GI2839@darkside.22.kls.lan>
Mail-Followup-To: Mario Holbe <Mario.Holbe@TU-Ilmenau.DE>,
	"Piszcz, Justin Michael" <justin.piszcz@mitretek.org>,
	linux-kernel@vger.kernel.org
References: <2E314DE03538984BA5634F12115B3A4E01BC42B1@email1.mitretek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E01BC42B1@email1.mitretek.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2005 at 09:05:05AM -0500, Piszcz, Justin Michael wrote:
> Okay but what hard drive model and IDE Chipset/Controller are you using?

VIA vt82c686b onboard
PDC20269 (Promise U133TX2) on PCI

hda: WDC WD400EB-00CPF0, ATA DISK drive
hdc: IC35L080AVVA07-0, ATA DISK drive
hdd: HL-DT-ST DVDRAM GSA-4082B, ATAPI CD/DVD-ROM drive
hdg: SAMSUNG SP1614N, ATA DISK drive

hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63, UDMA(100)
hdc: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=159560/16/63, UDMA(100)
hdg: 312581808 sectors (160042 MB) w/8192KiB Cache, CHS=19457/255/63, UDMA(100)

However, it doesn't matter :)


Mario
-- 
<delta> talk softly and carry a keen sword
