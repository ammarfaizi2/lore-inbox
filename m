Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbRGSV55>; Thu, 19 Jul 2001 17:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266081AbRGSV5r>; Thu, 19 Jul 2001 17:57:47 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19204 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266103AbRGSV5q>; Thu, 19 Jul 2001 17:57:46 -0400
Subject: Re: Errors on compiling kernel with iomega buz support
To: ernfran@gecpalau.com (root)
Date: Thu, 19 Jul 2001 22:58:14 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01071919592800.16303@rieacs1.gecpalau.com> from "root" at Jul 19, 2001 07:59:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15NLoE-0000MT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Any ideas when this thing will be fixed in the kernel?

The buz driver is obsolete. Use a -ac kernel or 2.4.7pre if you need buz
support
