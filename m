Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293467AbSCASPb>; Fri, 1 Mar 2002 13:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293469AbSCASOw>; Fri, 1 Mar 2002 13:14:52 -0500
Received: from mail.myrio.com ([63.109.146.2]:31219 "HELO mail.myrio.com")
	by vger.kernel.org with SMTP id <S293467AbSCASOH> convert rfc822-to-8bit;
	Fri, 1 Mar 2002 13:14:07 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
Date: Fri, 1 Mar 2002 10:12:27 -0800
Message-ID: <A015F722AB845E4B8458CBABDFFE63420FE3BC@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
Thread-Index: AcHBSbgCMYi4oMUHTjCwzXBrJw3NUgAASBog
From: "Torrey Hoffman" <Torrey.Hoffman@myrio.com>
To: <root@chaos.analogic.com>, "Zwane Mwaikambo" <zwane@linux.realnet.co.sz>
Cc: "Matthew Allum" <mallum@xblox.net>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Mar 2002 18:13:22.0275 (UTC) FILETIME=[C5C48330:01C1C14C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson [mailto:root@chaos.analogic.com] wrote:

[... snipped: using 2.4.1 because... ]

> Later versions, including the current 2.4.18 fail, to mount an initrd.

I have successfully used ext2-formatted initrd's with a variety of recent 
kernels between 2.4.16 and 2.4.18.  The only problem I've ever had is that 
when _building_ an initrd, kernels between 2.4.10 and 2.4.18-pre-something
had a bug in the ramdisk driver.  This has been fixed in later kernels, 
and there is also a workaround for it.

> Once somebody makes a kernel they has both a working loop device and
> a working initial RAM Disk, I will use that kernel. In the meantime,

My workstation is running a 2.4.18-pre? which successfully mounts CDROM
ISO images on loopback and successfully creates and boots initrd's.

Are you sure this is not something specific to your setup or config?

Torrey Hoffman
