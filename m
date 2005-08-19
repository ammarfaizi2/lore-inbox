Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbVHSSDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbVHSSDy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 14:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVHSSDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 14:03:54 -0400
Received: from odyssey.analogic.com ([204.178.40.5]:20234 "EHLO
	odyssey.analogic.com") by vger.kernel.org with ESMTP
	id S965053AbVHSSDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 14:03:53 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A4E8.42CC9980"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
In-Reply-To: <20050819174942.GA14713@cft.edu.pl>
References: <20050819174942.GA14713@cft.edu.pl>
X-OriginalArrivalTime: 19 Aug 2005 18:03:11.0728 (UTC) FILETIME=[433BAF00:01C5A4E8]
Content-class: urn:content-classes:message
Subject: Re: floppy driver in 2.6.12.5
Date: Fri, 19 Aug 2005 14:02:57 -0400
Message-ID: <Pine.LNX.4.61.0508191359030.6049@chaos.analogic.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: floppy driver in 2.6.12.5
Thread-Index: AcWk6ENC5GCuhGqpRmCs7N64qlmVfQ==
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Cezary Sliwa" <sliwa@blue.cft.edu.pl>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A4E8.42CC9980
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


On Fri, 19 Aug 2005, Cezary Sliwa wrote:

>
> Just wanted to format a floppy disk with fdformat, no way:
>
> Aug 14 22:28:45 kwant kernel: floppy0: unexpected interrupt
> Aug 14 22:28:45 kwant kernel: floppy0: sensei repl[0]=3D80
> Aug 14 22:28:49 kwant kernel: floppy0: -- FDC reply errorfloppy0:=
 unexpected interrupt
> Aug 14 22:28:49 kwant kernel: floppy0: sensei repl[0]=3D80
> Aug 14 22:28:51 kwant kernel: floppy0: -- FDC reply error<4>IN=3Dppp0 OUT=
=3D MAC=3D SRC=3D81.190.249.26 DST=3D83.24.228.114 LEN=3D60 TOS=3D0x00 PREC=
=3D0x00 TTL=3D120 ID=3D51789 PROTO=3DUDP SPT=3D4672 DPT=3D4672 LEN=3D40
> Aug 14 22:29:04 kwant kernel: IN=3Dppp0 OUT=3D MAC=3D SRC=3D83.25.145.251=
 DST=3D83.24.228.114 LEN=3D60 TOS=3D0x00 PREC=3D0x00 TTL=3D122 ID=3D33367=
 PROTO=3DUDP SPT=3D4685 DPT=3D4672 LEN=3D40
> Aug 14 22:29:07 kwant kernel: floppy0: unexpected interrupt
> Aug 14 22:29:07 kwant kernel: floppy0: sensei repl[0]=3D80
> Aug 14 22:29:07 kwant kernel: floppy0: seek failed
>
> Linux version 2.6.12.5 (root@kwant) (gcc version 2.95.3 20010315=
 (release))
> #1 Thu Aug 18 21:12:45 CEST 2005
>
> nforce2 mobo, nec fdd
>

What is floppy0?

I just formatted a floppy on version 2.6.12.5, shown in the
attached. You need to use /dev/fd0H1440  or similar device-names.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.12.5 on an i686 machine (5537.79 BogoMips).
Warning : 98.36% of all statistics are fiction.
.
I apologize for the following. I tried to kill it with the above dot :


****************************************************************
The information transmitted in this message is confidential and may be=
 privileged.  Any review, retransmission, dissemination, or other use of=
 this information by persons or entities other than the intended recipient=
 is prohibited.  If you are not the intended recipient, please notify=
 Analogic Corporation immediately - by replying to this message or by=
 sending an email to DeliveryErrors@analogic.com - and destroy all copies=
 of this information, including any attachments, without reading or=
 disclosing them.

Thank you.
------_=_NextPart_001_01C5A4E8.42CC9980
Content-Type: APPLICATION/x-gzip;
	name="typescript.gz"
Content-Transfer-Encoding: base64
Content-Description: typescript.gz
Content-Disposition: attachment;
	filename="typescript.gz"

H4sICAkeBkMAA3R5cGVzY3JpcHQA7VpNb+NGDL0GBvwLchmgl3axTURyZmg7l36kiwBFixa76CXo
wbWdtbGxZdhy0fz7SsxaCjYS3w9oDUSIIj/qRRw+PhHzfnHY7KtwrOaHarUM5S68O2wCTcP3p4+B
iyKFgmYpz4oYfvsl/HT7YXR/KMvqu8V6Xh5D8+ufX4WH5aG8uLz/+fyzfCgP23kVrperv68flgXF
WIxHL89m4dcyHE+LdXjYPK5CeQjLzWG1qMrD07j/Dj0hL+pP77cfj/a9RcOl/vKb8ejyvii2l/ex
uBG5KWh7DmN/D58/r6/TiYjbL72+Lj+W2/38989feH09nkizg8/ryeT5ckPxFTsQvWZXPwWH3VK6
m/ezm3j4fKIiOvRA+Jpe9v55uYX0pt7Dz11yeumB8A29iUtP2afHEw+fu+z00/PD1/SU2aG3rv95
5/bxJO713GWnlx4I39CL4tJz12ZNL4HkZq80QHgChSd3kJ67eHKXnV56IDyBymuenmaXHqrcc3aG
np4XnkDlNfSm0aPnr+3cZWeInheeQOXV9FzhiadJAehNvMoF4QlUnqyR7k3Q05t6ugfCE6g8uYP0
xKfHblMD4QlUnqwjedcTaOm5y07/0/PDE6i8mp6bvAR6eu6yM0APdA2/8mTtX0+gp+c2O/3sUE/z
C0/uADvQlHKXnP6lB+mBh/dCdvrpuaqf2+T0Pzw/OoG6k86tDbLzRD+3yellB6IzKDsBTjoBzc9t
bgbYudEZVJ0AJ52A5Oc2NwPs3OgMik6AkU5A8dVj5kZm4KEFeOgE1FRf5GWInxefgYkWYKITkFNd
unIHojOQKwEeOgE51S7+ED0vPAO5EuChExAsXfsvQCA8Aw8twEMnoFja6eEAPTc8AzkV4KETkCzt
BHGAnhuegZ4K8NAJaJau/ddHEJ6BoArw0AkIl679wvWjMxBUARY6AdnSVhYH2LnRGThoAQ46AdnS
VhQH2LnRGUi+AAOdgGrp2jVRIDoDwRfgnxMQLfUHeiA6A8EX4J8T0CwFAz0QnoF/FuCfE9AsBQM9
EJ5BPxJgoBPQLAUDPRCeQT9qxXrAQScgWuoP9AiEZ9CPIrDQCaiW+gM9AuEZ9KMIPHQCsqX+QI9A
eAb9KAIrmIBuqT/QI+DTGTSkCKxgAsKl/kCPgE1n0JEi8FoJCJf6Az0CyWHQkiLwWgkIl/oDPQLJ
YdCTIvBaCQiX+gM9Aj6dQVOKwGy1eR8QLvUHegTWDoOmFIGfyUC41B/oEVg7DJpSBIYmA+FSd6BH
YOkw6EkRGJoMKk/9gR6BpcOgJ0XgGDKoPHUHegR8OoOWFIFhyGBlqzvQI7CuGXSkCPxCBgtb3YEe
gWXNoCFFYBcyWNjqDvQILGsG/SgCt5Ddt1cCNpxBu4nADGT37ZRAzTDoJhH0+uy+fRKoibZLDzSL
CFp5fvF22e5Ymdn+EbqRvD3f+nxOX5zzF+edZdsO71Opb/HmovsM7nW56za93Janvx5X3x43y9Xy
bZgUoTrMF5+ObwNNwnG1uLbTq/ChrOaPYTHfzxeb6ik0+PDph6vx6J3dodrsPoarq6v6UTRxQyA7
sh3FjtGOyY7ZjmrHiR2nzZEMS4Ylw5JhybBkWDIsGZYMS4Zlw7Jh2bBsWDYsG5YNy4Zlw7JhxbBi
WDGsGFYMK4YVw4phxbBiWHuOIRo2GjYaNho2GjYaNho2GjYaNhk2GTYZNhk2GTYZNhk2GTYZNhk2
GzYbNhs2GzYbNhs2GzYbNhs2G1YNq4ZVw6ph1bBqWDWsGlYNqw12We5W49Efq8Pm4en/nP+Xct63
l67ZcfesLY/lfv/Ubs17PpvVerHblVUo96td+PrlpW96463+2VTj0ej9807C5rZD2winM9HzNsJ/
AdjbEDN5KAAA

------_=_NextPart_001_01C5A4E8.42CC9980--
