Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262024AbVCHLkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262024AbVCHLkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 06:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbVCHLhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 06:37:14 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:18051 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262010AbVCHL07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 06:26:59 -0500
Subject: Re: [PATCH] resync ATI PCI idents into base kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e050308024214400e1f@mail.gmail.com>
References: <200503072216.j27MGxtP024504@hera.kernel.org>
	 <20050308053941.GA16450@kroah.com>
	 <1110276929.28860.93.camel@localhost.localdomain>
	 <58cb370e050308024214400e1f@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110281106.3072.112.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 08 Mar 2005 11:25:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-08 at 10:42, Bartlomiej Zolnierkiewicz wrote:
> > Really - so does it go to the PCI maintainer, the IDE maintainer or the
> > DRI maintainer or someone else, or all of them, or in bits to different
> > ones remembering there are dependancies and I don't use bitcreeper ?
> 
> it should go to /dev/null because there are no users of these IDs ;-)

See the problem - and I'm about to send you a patch so you can use the
SI3112 driver with the ATI hardware because the Jeff Garzik one still
fails for some users quite badly (and no I don't know why either).

Alan

