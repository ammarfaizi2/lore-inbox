Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265192AbTFRMgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 08:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265206AbTFRMgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 08:36:03 -0400
Received: from mail.ithnet.com ([217.64.64.8]:49927 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S265192AbTFRMgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 08:36:02 -0400
Date: Wed, 18 Jun 2003 14:49:38 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Pascal Schmidt <der.eremit@email.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
Message-Id: <20030618144938.3ded97a3.skraw@ithnet.com>
In-Reply-To: <E19ScKA-0000Pt-00@neptune.local>
References: <20030507203025$6f60@gated-at.bofh.it>
	<20030509005011$6cee@gated-at.bofh.it>
	<20030509101012$732a@gated-at.bofh.it>
	<20030509122007$758f@gated-at.bofh.it>
	<20030509131009$00f3@gated-at.bofh.it>
	<20030611045008$03cf@gated-at.bofh.it>
	<E19ScKA-0000Pt-00@neptune.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003 14:46:02 +0200
Pascal Schmidt <der.eremit@email.de> wrote:

> Stephan von Krawczynski wrote in linux-kernel:
> 
> > around 70-100 GB of data is transferred to a nfs-server with rc8 onto a RAID5
> > on 3ware-controller.
> > The data is then copied via tar onto a SDLT drive connected to an aic
> > controller.
> > Afterwards the data is verified by tar.
> 
> Have you tried with a different SCSI controller to rule out bugs in st.c?

Replacement part is not yet shipped.

Regards,
Stephan
