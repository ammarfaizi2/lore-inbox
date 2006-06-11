Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751632AbWFKPst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWFKPst (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWFKPst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 11:48:49 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:28584 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751279AbWFKPss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 11:48:48 -0400
Subject: Re: [RFC] ATA host-protected area (HPA) device mapper?
From: Arjan van de Ven <arjan@infradead.org>
To: Etienne Lorrain <etienne_lorrain@yahoo.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, jeff@garzik.org
In-Reply-To: <20060610115636.57029.qmail@web26907.mail.ukl.yahoo.com>
References: <20060610115636.57029.qmail@web26907.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Sun, 11 Jun 2006 17:48:39 +0200
Message-Id: <1150040920.3131.74.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  The simple solution is: you never boot from the hard disk, but from a
>  physically write protected device (write protected floppy, non writeable
>  CD or CDRW in a non writing CDROM drive, USB thumb drive with a physical
>  write protect switch).


that's not totally fool proof either; after all an attacker can adjust
the nvram to change the boot device order.



