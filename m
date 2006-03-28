Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWC1OUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWC1OUY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 09:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWC1OUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 09:20:24 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:5793 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932278AbWC1OUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 09:20:23 -0500
Date: Tue, 28 Mar 2006 16:20:09 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Eric Piel <Eric.Piel@tremplin-utc.net>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
In-Reply-To: <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
Message-ID: <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr>
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com>
 <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net>
 <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Eh, not really.  "__inline__" is GCC-specific and probably won't work in other
> compilers (unless you did "#define __inline__", which would bloat the code a
> lot).
>
But ___inline is a C99 keyword, isnot it?




Jan Engelhardt
-- 
