Return-Path: <linux-kernel-owner+w=401wt.eu-S1762256AbWLJRBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762256AbWLJRBx (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 12:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762257AbWLJRBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 12:01:53 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52557 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762256AbWLJRBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 12:01:52 -0500
Date: Sun, 10 Dec 2006 17:08:43 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Alan Chandler <alan@chandlerfamily.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE support on Intel DG965SS
Message-ID: <20061210170843.2902492e@localhost.localdomain>
In-Reply-To: <200612101558.34005.alan@chandlerfamily.org.uk>
References: <200612101558.34005.alan@chandlerfamily.org.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 15:58:33 +0000
Alan Chandler <alan@chandlerfamily.org.uk> wrote:

> I have been trying to find out if the kernel supports the IDE channel 
> (with a DVD/CD-R unit attached) on my Intel DG965SS motherboard.

2.6.19-mm and thus hopefully 2.6.20 will support the Marvell via libata
driver pata_marvell.

Alan
