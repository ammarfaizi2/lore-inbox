Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUEVIRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUEVIRN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 04:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbUEVIRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 04:17:13 -0400
Received: from zero.aec.at ([193.170.194.10]:7173 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264916AbUEVIRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 04:17:08 -0400
To: Corin Langosch <corinl@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: dual opteron problems, tyan 2870 board
References: <1Yuhl-2nK-15@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 22 May 2004 10:17:05 +0200
In-Reply-To: <1Yuhl-2nK-15@gated-at.bofh.it> (Corin Langosch's message of
 "Sat, 22 May 2004 04:20:11 +0200")
Message-ID: <m3ekpcq3jy.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corin Langosch <corinl@gmx.de> writes:

> i just bought a new 2x244 opteron,tyan tiger k8s 2870,
> 4gb registered ecc ram system. no addional cards
> inserted, only one IDE and one SATA device.

[...]

Sounds like hardware problems on your board. It is unlikely that
any kernel can fix them.

e.g. run memtest86 over night to check the memory and probably
something is wrong with your second CPU too.

I would talk to whoever sold you the kit.

-Andi

