Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267154AbUBSAFf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 19:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267157AbUBSAFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 19:05:35 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:28032
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S267154AbUBSAFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 19:05:32 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Intel x86-64 support merge
References: <1qHr5-2tJ-39@gated-at.bofh.it> <1qHr5-2tJ-37@gated-at.bofh.it> <1qIZw-6b9-17@gated-at.bofh.it> <1qJsI-6Be-57@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 18 Feb 2004 16:05:22 -0800
In-Reply-To: <1qJsI-6Be-57@gated-at.bofh.it>
Message-ID: <ugisi4vsql.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 19 Feb 2004 00:40:24 +0100, Arjan van de Ven <arjan@fenrus.demon.nl> said:

  Arjan> On Wed, 2004-02-18 at 23:57, H. Peter Anvin wrote:
  >>  Because they were caught by surprise and just hacked the chips
  >> they had in the pipeline, presumably.

  Arjan> fair enough; I hope this means the next generation has this
  Arjan> wart fixed...

I wouldn't hold my breath.  My impression was that the Intel chipset
folks don't want I/O MMU because (a) Windows doesn't need it and (b)
real machines use (close-to-)64-bit-capable hardware.

	--david
