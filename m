Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbSAZNSO>; Sat, 26 Jan 2002 08:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284300AbSAZNSF>; Sat, 26 Jan 2002 08:18:05 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:18422 "EHLO
	host140.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280588AbSAZNRw>; Sat, 26 Jan 2002 08:17:52 -0500
Date: Sat, 26 Jan 2002 13:17:51 +0000 (GMT)
From: Bernd Schmidt <bernds@redhat.com>
X-X-Sender: <bernds@host140.cambridge.redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Panic on boot with 2.4.18pre3ac1
In-Reply-To: <Pine.LNX.4.33.0201261258460.15848-100000@host140.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.33.0201261315350.15848-100000@host140.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2002, Bernd Schmidt wrote:

> About every second time I try to boot 2.4.18pre3ac1, the kernel panics
> while trying to detect the SCSI hardware.  There's lots of debugging output
> which I have't copied to paper, but there's the following messages:
> 
> Scratch or SCB Memory Parity Error
> [...]
> Attempting to queue an ABORT message
> [...]
> Kernel panic: Loop 1
> 
> This did not happen with earlier kernels (I've been using 2.4.10ac10 mostly,
> but 2.4.15 didn't seem to have the problem either).

Umm, I noticed I didn't mention what kind of SCSI hardware I have.  This is
a rather old PCI Adaptec 2940 card, with only a CD writer attached to it.


Bernd

