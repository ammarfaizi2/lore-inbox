Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSJ1QAX>; Mon, 28 Oct 2002 11:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261327AbSJ1QAX>; Mon, 28 Oct 2002 11:00:23 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42192 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261321AbSJ1QAW>; Mon, 28 Oct 2002 11:00:22 -0500
Subject: Re: Linux 2.5.44-ac3
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Doug Ledford <dledford@redhat.com>
Cc: Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021028151517.GA18875@redhat.com>
References: <200210251019.g9PAJ8V14406@devserv.devel.redhat.com> 
	<20021028151517.GA18875@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Oct 2002 16:25:25 +0000
Message-Id: <1035822325.1965.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-28 at 15:15, Doug Ledford wrote:
> On Fri, Oct 25, 2002 at 06:19:08AM -0400, Alan Cox wrote:
> >    Doug's scsi changes broke mptfusion. I've not looked into that yet
> >    also u14f/u34f.
> 
> Fixed in linux-scsi.bkbits.net/scsi-misc-2.5  Well, the mptfusion is, not 
> sure about u14f/u34f.  I think I have that turned off in my builds because 
> it was still broken in regards to the PCI DMA mapping API last I knew.

mpt-fusion is fixed in -ac now, I dont know if its the same patch. As to
u14-34f well "bitkeeper how quaint". Send me a patch if you want me to
roll it into -ac

