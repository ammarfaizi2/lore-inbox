Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264091AbRF0LCk>; Wed, 27 Jun 2001 07:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbRF0LCa>; Wed, 27 Jun 2001 07:02:30 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36624 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S264091AbRF0LCQ>; Wed, 27 Jun 2001 07:02:16 -0400
Subject: Re: failed kernel 2.4.2 build after applying the patch ac28
To: hiren_mehta@agilent.com ("MEHTA,HIREN (A-SanJose,ex1)")
Date: Wed, 27 Jun 2001 12:02:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <FEEBE78C8360D411ACFD00D0B7477971880ACA@xsj02.sjs.agilent.com> from "MEHTA,HIREN (A-SanJose,ex1)" at Jun 26, 2001 03:35:09 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FD56-0004zx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> *** Install db development libraries
> I thought kernel build should be independent of any userland libraries.

The kernel is, the tools are not

