Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934374AbWKUPAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934374AbWKUPAm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 10:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934375AbWKUPAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 10:00:42 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44442 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S934374AbWKUPAl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 10:00:41 -0500
Date: Tue, 21 Nov 2006 15:06:15 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: first proposal for pci resume quirk interface
Message-ID: <20061121150615.3c2f3616@localhost.localdomain>
In-Reply-To: <45631455.9000805@gmx.net>
References: <20061114175510.6e7c7119@localhost.localdomain>
	<45631455.9000805@gmx.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I sent a similar patch about one year ago and it was rejected back then.
> Any reasons why fixups on resume suddenly are desirable?

Well for one your disk turns to mush on some VIA systems if you don't 8)

> (I agree with the patch wholehartedly and will test it ASAP on my
> Samsung P35 laptop which needs the asus_hides_smbus quirk.)

It should fix that bug as well.

Alan
