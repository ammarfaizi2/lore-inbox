Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143978AbRA1UHH>; Sun, 28 Jan 2001 15:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144076AbRA1UG4>; Sun, 28 Jan 2001 15:06:56 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:38863 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S143978AbRA1UGk>; Sun, 28 Jan 2001 15:06:40 -0500
Message-ID: <002601c08964$7186d2d0$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: "Bruce Harada" <bruce@ask.ne.jp>, <linux-kernel@vger.kernel.org>
In-Reply-To: <003f01c088fb$a35c06e0$b001a8c0@caesar> <20010128174016.3fba71ad.bruce@ask.ne.jp><002901c08951$f751bfa0$b001a8c0@caesar> <20010129043143.3ac5fd99.bruce@ask.ne.jp>
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Date: Sun, 28 Jan 2001 14:56:45 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0023_01C0893A.888DB270"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0023_01C0893A.888DB270
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Sorry, forget this last email. Here is hdparm output.


------=_NextPart_000_0023_01C0893A.888DB270
Content-Type: application/octet-stream;
	name="hdparm"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hdparm"

=0A=
/dev/hdd:=0A=
=0A=
 Model=3DIBM-DTLA-307030, FwRev=3DTX4OA50C, SerialNo=3DYKDYKT8D495=0A=
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }=0A=
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D40=0A=
 BuffType=3DDualPortCache, BuffSize=3D1916kB, MaxMultSect=3D16, =
MultSect=3Doff=0A=
 CurCHS=3D16383/16/63, CurSects=3D-66060037, LBA=3Dyes, =
LBAsects=3D60036480=0A=
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}=0A=
 PIO modes: pio0 pio1 pio2 pio3 pio4 =0A=
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 =0A=
=0A=
 Model=3DBI-MTDAL3-7030 0                        , FwRev=3DXTO45AC0, =
SerialNo=3D        Y DKKY8T4D59=0A=
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }=0A=
 RawCHS=3D16383/16/63, TrkSize=3D0, SectSize=3D0, ECCbytes=3D40=0A=
 BuffType=3DDualPortCache, BuffSize=3D1916kB, MaxMultSect=3D16, =
MultSect=3Doff=0A=
 CurCHS=3D16383/16/63, CurSects=3D-66060037, LBA=3Dyes, =
LBAsects=3D60036480=0A=
 IORDY=3Don/off, tPIO=3D{min:240,w/IORDY:120}, tDMA=3D{min:120,rec:120}=0A=
 PIO modes: pio0 pio1 pio2 pio3 pio4 =0A=
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5 =0A=

------=_NextPart_000_0023_01C0893A.888DB270--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
