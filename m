Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278225AbRJWUjG>; Tue, 23 Oct 2001 16:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278221AbRJWUis>; Tue, 23 Oct 2001 16:38:48 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278227AbRJWUim>; Tue, 23 Oct 2001 16:38:42 -0400
Subject: Re: HPT370/366 testers needed
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Tue, 23 Oct 2001 21:45:26 +0100 (BST)
Cc: thockin@sun.com (Tim Hockin),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20011023152547.E27797@redhat.com> from "Benjamin LaHaise" at Oct 23, 2001 03:25:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15w8QQ-0000xh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the bios set it to something less than we expect it to, or to leave 
> this kind of pci hackery to the generic pci layer.  It's important to
> note that quite a few drivers share this bug at present.  Cheers,

Time for pci_set_cacheline_size() ?
