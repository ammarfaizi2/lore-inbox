Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265916AbUF2S7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265916AbUF2S7B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 14:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUF2S7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 14:59:00 -0400
Received: from palrel13.hp.com ([156.153.255.238]:60632 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S265916AbUF2S4g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 14:56:36 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16609.47965.922863.441817@napali.hpl.hp.com>
Date: Tue, 29 Jun 2004 11:56:29 -0700
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [profile]: [10/23] ia64 profiling cleanups
In-Reply-To: <0406220816.Mb0a5a5a5a1a5a3aKbKb0a3a4a0aHbZaIbJbLb5a3aJbHbXaWaMb2aHb0a1aKbWa15250@holomorphy.com>
References: <0406220816.0a0a1aMbIbXa5a1aIb1a2aJbYaLbLb5aXaHbZaXaIbXa2aWaJbMbIbZa5a5aZa4a15250@holomorphy.com>
	<0406220816.Mb0a5a5a5a1a5a3aKbKb0a3a4a0aHbZaIbJbLb5a3aJbHbXaWaMb2aHb0a1aKbWa15250@holomorphy.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 22 Jun 2004 08:17:09 -0700, William Lee Irwin III <wli@holomorphy.com> said:

  William> Convert ia64 to use profiling_on() and profile_tick().

This patch looks fine to me (well, it took me a while to figure out
that you hid profiling_on() and profile_tick() inside the ppc32 diff;
bad boy! ;-).

	--david
