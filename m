Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUKAPuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUKAPuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 10:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273784AbUKAPuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:50:40 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:11148 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S271757AbUKAPaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 10:30:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=UOQMEsyoow07a25mEZLDJrXf5R2hspWvGIpCCAXJAvfe/w0hV9L3jWrbKDgjTZUrv0PDU/U37KKZau+iXrmlOUdz8kg+A8WvC5ODhNRWvw7eURr/fSYZmacg0+/+n6GSmYs1suPOTD3B6YNwW9/TlNkzNCGLZkjXnAHdXFxe7PU=
Message-ID: <5786143704110107302e1722d8@mail.gmail.com>
Date: Mon, 1 Nov 2004 09:30:13 -0600
From: Jesus Delgado <jdelgado@gmail.com>
Reply-To: Jesus Delgado <jdelgado@gmail.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Subject: Re: [2.6.10-rc1-mm2] keyboard / synaptics not working
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410311903.06927@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_265_30265500.1099323013777"
References: <200410311903.06927@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_265_30265500.1099323013777
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all:
 
    Iam have is the same problems, kernel 2.6.10-rc1 keryboard and
mouse OK ( emachines M6709), both running kernel 2.6.10-rc1-mm2 the
keyboard and mouse NOT WORKING.

  anex my file dsdt.hex.gz

Helpme please.

On Sun, 31 Oct 2004 19:03:06 +0100, Alexander Gran
<alex@zodiac.dnsalias.org> wrote:
> Hi,
> 
> using 2.6.10-rc1-mm2 my keyboard and synaptics do not work. 2.6.9-rc4-mm1 is
> fine. Both bootlogs are attached.
> lspci (using 2.6.8-rc3-mm1)  gives
> 0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O Controller (rev
> 03)
> 0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller (rev
> 03)
> 0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> USB UHCI Controller #1 (rev 01)
> 0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> USB UHCI Controller #2 (rev 01)
> 0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
> USB UHCI Controller #3 (rev 01)
> 0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB 2.0
> EHCI Controller (rev 01)
> 0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81)
> 0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev
> 01)
> 0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA Storage
> Controller (rev 01)
> 0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus
> Controller (rev 01)
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97
> Modem Controller (rev 01)
> 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 Lf
> [Radeon Mobility 9000 M9] (rev 02)
> 0000:02:00.0 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> Controller (rev 01)
> 0000:02:00.1 CardBus bridge: Texas Instruments PCI1520 PC card Cardbus
> Controller (rev 01)
> 0000:02:01.0 Ethernet controller: Intel Corp. 82540EP Gigabit Ethernet
> Controller (Mobile) (rev 03)
> 0000:02:02.0 Ethernet controller: Atheros Communications, Inc. AR5211 802.11ab
> NIC (rev 01)
> 
> The 2.6.10-rc1-mm2 config is attached,too.
> 
> regards
> Alex
> 
> --
> Encrypted Mails welcome.
> PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291
> 
> 
>

------=_Part_265_30265500.1099323013777
Content-Type: application/gzip; name="dsdt.hex.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dsdt.hex.gz"

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
IOjZh9d1os6aRPZnIMr8I5yS/wN5cx6y2UIAAA==
------=_Part_265_30265500.1099323013777--
