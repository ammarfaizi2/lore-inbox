Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269742AbUJAKVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269742AbUJAKVp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269744AbUJAKVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:21:45 -0400
Received: from palrel13.hp.com ([156.153.255.238]:53405 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S269742AbUJAKVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:21:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16733.12213.315295.653547@napali.hpl.hp.com>
Date: Fri, 1 Oct 2004 03:21:41 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       kai@germaschewski.name, sam@ravnborg.org, davidm@hpl.hp.com
Subject: Re: [ia64 patch 2.6.9-rc3] build: ccache/distcc fix for ia64
In-Reply-To: <20041001101040.GA25104@elte.hu>
References: <20041001101040.GA25104@elte.hu>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 1 Oct 2004 12:10:40 +0200, Ingo Molnar <mingo@elte.hu> said:

  Ingo> the (tested) patch below fixes ccache/distcc-assisted building
  Ingo> of the ia64 tree. (CC is "ccache distcc gcc" in that case, not
  Ingo> a simple one-word "gcc" - this confused the check-gas and
  Ingo> toolchain-flags scripts.)

Looks fine to me.

Thanks,

	--david
