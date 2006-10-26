Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945956AbWJZWEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945956AbWJZWEE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 18:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945957AbWJZWEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 18:04:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47305 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1945956AbWJZWEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 18:04:02 -0400
Subject: Re: removing drivers and ISA support? [Was: Char: correct
	pci_get_device changes]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <4540F79C.7070705@gmail.com>
References: <4540F79C.7070705@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 26 Oct 2006 23:07:26 +0100
Message-Id: <1161900446.12781.86.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-10-26 am 19:59 +0200, ysgrifennodd Jiri Slaby:
> Alan, do you consider some (char) driver to be removed now?

I think some of the drivers like epca we should seriously consider
dropping and seeing if there is any complaint, my guess will be not.

> And what about (E)ISA support. When converting to pci probing, should be ISA bus
> support preserved (how much is ISA used in present)? -- it makes code ugly and long.

Your guess is as good as mine 8)

