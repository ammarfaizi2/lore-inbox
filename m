Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267639AbUBRRsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267640AbUBRRsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:48:11 -0500
Received: from palrel11.hp.com ([156.153.255.246]:25265 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S267639AbUBRRsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:48:06 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16435.42315.529207.505662@napali.hpl.hp.com>
Date: Wed, 18 Feb 2004 09:47:55 -0800
To: Pat Gefre <pfg@sgi.com>
Cc: akpm@osdl.org, davidm@napali.hpl.hp.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [2.6 PATCH] Altix update
In-Reply-To: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
References: <200402181441.i1IEfIWX024531@fsgi900.americas.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 18 Feb 2004 08:41:18 -0600 (CST), Pat Gefre <pfg@sgi.com> said:

  Pat> Andrew, Here's a small mod for Altix. It breaks up our 'pci
  Pat> fixup' function and has some other smallish clean ups.

  Pat> For the ia64 crowd I've added 'platform_data' back into
  Pat> include/asm-ia64/pci.h

Please don't send such patches to Andrew.  I don't want to have
divergence on fundamental ia64 data structures.

  Pat> Can you take this ?

Feel free to send me incremental ia64 patches.  I asked you to send
the monster SN2 update patch to Andrew because I didn't want to get
stuck with it in my tree.  But now that that is taken care of, I'm
perfectly happy to handle your incremental patches.

	--david
