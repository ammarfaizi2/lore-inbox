Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWC1RIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWC1RIv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 12:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbWC1RIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 12:08:51 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:61921 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S1751160AbWC1RIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 12:08:50 -0500
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Eric Piel <Eric.Piel@tremplin-utc.net>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
References: <200603141619.36609.mmazur@kernel.pl>
	<20060326065205.d691539c.mrmacman_g4@mac.com>
	<4426A5BF.2080804@tremplin-utc.net>
	<200603261609.10992.rob@landley.net>
	<44271E88.6040101@tremplin-utc.net>
	<5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
From: Catalin Marinas <catalin.marinas@arm.com>
Date: Tue, 28 Mar 2006 18:08:03 +0100
In-Reply-To: <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> (Kyle Moffett's
 message of "Sun, 26 Mar 2006 19:40:14 -0500")
Message-ID: <tnxr74msdjg.fsf@arm.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 28 Mar 2006 17:08:06.0020 (UTC) FILETIME=[2E2B6C40:01C6528A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
> That brings up one final point: Does anybody actually use any
> compilers on Linux other than GCC?

Yes, some people use (or plan to use) the ARM Ltd toolchain
(http://www.arm.com/products/DevTools/RVCT.html) to cross-compile
applications for Linux (mainly for a better size/performance).

-- 
Catalin
