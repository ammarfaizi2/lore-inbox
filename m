Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTFQAgs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 20:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTFQAg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 20:36:29 -0400
Received: from palrel13.hp.com ([156.153.255.238]:15338 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264479AbTFQAfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 20:35:32 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16110.26004.617247.908953@napali.hpl.hp.com>
Date: Mon, 16 Jun 2003 17:49:24 -0700
To: Art Haas <ahaas@airmail.net>
Cc: David Mosberger-Tang <davidm@hpl.hp.com>, linux-ia64@linuxia64.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] C99 initializers for asm-ia64/include/xor.h
In-Reply-To: <20030617004618.GC21500@artsapartment.org>
References: <20030617004618.GC21500@artsapartment.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 16 Jun 2003 19:46:18 -0500, Art Haas <ahaas@airmail.net> said:

  Art> Hi.
  Art> This patch converts the file to use C99 initializers. The patch is
  Art> against the current BK and is untested as I don't have access to the
  Art> hardware.

The patch won't apply on the current ia64 tree, but I'll make the
analogous change.

Thanks,

	--david
