Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268405AbTCFVgi>; Thu, 6 Mar 2003 16:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268407AbTCFVgh>; Thu, 6 Mar 2003 16:36:37 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:24232
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268405AbTCFVgg>; Thu, 6 Mar 2003 16:36:36 -0500
Subject: Re: Linux 2.4.21pre5-ac2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Sebor <petr@scssoft.com>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E67C050.10500@scssoft.com>
References: <200303061915.h26JFhP06388@devserv.devel.redhat.com>
	 <3E67C050.10500@scssoft.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046991149.17715.131.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 06 Mar 2003 22:52:33 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-06 at 21:40, Petr Sebor wrote:
> hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
> Partition check:
>  hdb:end_request: I/O error, dev 03:40 (hdb), sector 0
> end_request: I/O error, dev 03:40 (hdb), sector 2
> end_request: I/O error, dev 03:40 (hdb), sector 4
> end_request: I/O error, dev 03:40 (hdb), sector 6
> end_request: I/O error, dev 03:40 (hdb), sector 0
> end_request: I/O error, dev 03:40 (hdb), sector 2
> end_request: I/O error, dev 03:40 (hdb), sector 4
> end_request: I/O error, dev 03:40 (hdb), sector 6
>  unable to read partition table
> 
> Started to happen on two different machines and didn't
> happen with pre4-ac7.

Is there a disk in at the time ?


