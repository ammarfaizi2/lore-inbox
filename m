Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTHTAbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbTHTAbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:31:53 -0400
Received: from zero.aec.at ([193.170.194.10]:51974 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261613AbTHTAbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:31:53 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [PATCH][2.6][5/5]Support for HPET based timer
From: Andi Kleen <ak@muc.de>
Date: Wed, 20 Aug 2003 02:31:28 +0200
In-Reply-To: <moRP.2r8.11@gated-at.bofh.it> (Jamie Lokier's message of "Wed,
 20 Aug 2003 02:20:09 +0200")
Message-ID: <m3vfstqie7.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <mmGp.wp.3@gated-at.bofh.it> <mnsM.1eL.13@gated-at.bofh.it>
	<moRP.2r8.11@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Even on those machines where APIC interrupts are not usable?
> (E.g. due to interactions with the SMM BIOS).

On those you can always use the old style PIT.

-Andi
