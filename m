Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTEMFnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTEMFnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:43:31 -0400
Received: from palrel13.hp.com ([156.153.255.238]:35548 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262946AbTEMFn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:43:28 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.35068.924842.310330@napali.hpl.hp.com>
Date: Mon, 12 May 2003 22:56:12 -0700
To: Chris Wright <chris@wirex.com>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, gregkh@kroah.com,
       linux-security-module@wirex.com, davidm@hpl.hp.com
Subject: Re: [PATCH] Early init for security modules
In-Reply-To: <20030512200953.N19432@figure1.int.wirex.com>
References: <20030512200309.C20068@figure1.int.wirex.com>
	<20030512200953.N19432@figure1.int.wirex.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 12 May 2003 20:09:53 -0700, Chris Wright <chris@wirex.com> said:

  Chris> This is just the arch specific linker bits for the early
  Chris> initialization for security modules patch.  Does this look
  Chris> sane for this arch?

Looks OK to me.

	--david
