Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWC1QNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWC1QNu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWC1QNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:13:50 -0500
Received: from vulpecula.futurs.inria.fr ([195.83.212.5]:13700 "EHLO
	vulpecula.futurs.inria.fr") by vger.kernel.org with ESMTP
	id S1751206AbWC1QNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:13:49 -0500
Message-ID: <442960B6.2040502@tremplin-utc.net>
Date: Tue, 28 Mar 2006 18:13:42 +0200
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Thunderbird 1.5 (X11/20060225)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Rob Landley <rob@landley.net>,
       nix@esperi.org.uk, mmazur@kernel.pl, linux-kernel@vger.kernel.org,
       llh-discuss@lists.pld-linux.org
Subject: Re: [OT] Non-GCC compilers used for linux userspace
References: <200603141619.36609.mmazur@kernel.pl> <20060326065205.d691539c.mrmacman_g4@mac.com> <4426A5BF.2080804@tremplin-utc.net> <200603261609.10992.rob@landley.net> <44271E88.6040101@tremplin-utc.net> <5DC72207-3C0B-44C2-A9E5-319C0A965E9D@mac.com> <Pine.LNX.4.61.0603281619300.27529@yvahk01.tjqt.qr> <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
In-Reply-To: <36A8C3CC-3E4D-4158-AABB-F4D2C66AA8CD@mac.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

03/28/2006 05:57 PM, Kyle Moffett wrote/a écrit:
> 
> But my question still stands.  Does anybody actually use any non-GCC 
> compiler for userspace in Linux?
At least in the domain of HPC, I've seen people which were compiling 
mostly *everything* with the intel compiler (x86 and ia64) for 
performance reason. So... yes userspace is sometimes compiled with 
non-GCC compiler :-)

Eric
