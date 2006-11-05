Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422804AbWKEXgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422804AbWKEXgE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 18:36:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWKEXgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 18:36:04 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:21924 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932604AbWKEXgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 18:36:02 -0500
Date: Mon, 6 Nov 2006 00:35:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Courtier-Dutton <James@superbug.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: i387  Floating Point Unit (FPU) testing
In-Reply-To: <454E54B6.5010206@superbug.co.uk>
Message-ID: <Pine.LNX.4.61.0611060035080.29462@yvahk01.tjqt.qr>
References: <454E54B6.5010206@superbug.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The kernel contains some i387 FPU emulation code.
> Is there any user land software to test the FPU emulation code?
> I would like to be able to prove the correctness of the FPU emulation code in
> the Linux kernel, and also port the test program to other platforms that
> utilize FPU emulation. For example, DOS emulators like DOSBOX.

If the kernel already emulates it, you don't really need emulation in 
userspace, no?

	-`J'
-- 
