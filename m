Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264914AbUGIKG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264914AbUGIKG5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 06:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264798AbUGIKEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 06:04:41 -0400
Received: from zero.aec.at ([193.170.194.10]:54025 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264910AbUGIKEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 06:04:05 -0400
To: Michael Buesch <mbuesch@freenet.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: GCC 3.4 and broken inlining.
References: <2fVEt-6Vy-11@gated-at.bofh.it> <2fVO5-79H-3@gated-at.bofh.it>
	<2fWqQ-7uv-19@gated-at.bofh.it> <2g0b6-1Cf-23@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Fri, 09 Jul 2004 12:04:02 +0200
In-Reply-To: <2g0b6-1Cf-23@gated-at.bofh.it> (Michael Buesch's message of
 "Fri, 09 Jul 2004 11:50:08 +0200")
Message-ID: <m3smc1pkdp.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch <mbuesch@freenet.de> writes:
>
> Do I miss something?

Yes.  Take a look at arch/i386/Makefile

-Andi

