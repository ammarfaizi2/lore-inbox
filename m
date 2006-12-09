Return-Path: <linux-kernel-owner+w=401wt.eu-S1761330AbWLIBKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761330AbWLIBKp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 20:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761333AbWLIBKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 20:10:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:40179 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761330AbWLIBKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 20:10:45 -0500
Date: Sat, 9 Dec 2006 01:18:30 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: koan <koan00@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: warning at drivers/scsi/ahci.c:859/ahci_host_intr() [
 2.6.17.14 ]
Message-ID: <20061209011830.14d99a20@localhost.localdomain>
In-Reply-To: <64d833020612081705p29c92e85i25f045ad87cb879e@mail.gmail.com>
References: <64d833020612081705p29c92e85i25f045ad87cb879e@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 20:05:07 -0500
koan <koan00@gmail.com> wrote:

> ata4: status=0x50 { DriveReady SeekComplete }
> ata4: error=0x01 { AddrMarkNotFound }

That looks like a genuine drive problem.

Alan
