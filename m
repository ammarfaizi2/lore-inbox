Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbVH1IIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbVH1IIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 04:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbVH1IIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 04:08:10 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15803 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750847AbVH1IIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 04:08:09 -0400
Date: Sun, 28 Aug 2005 10:07:56 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michael Marineau <marineam@engr.orst.edu>
Cc: Andrew Morton <akpm@osdl.org>, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Generic acpi vgapost
Message-ID: <20050828080756.GA2039@elf.ucw.cz>
References: <43111298.80507@engr.orst.edu> <43111313.8000800@engr.orst.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43111313.8000800@engr.orst.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Generic function to post the video bios.
> 
> Based directly on the original patch by Ole Rohne.
> 
> Signed-off-by: Michael Marineau <marineam@engr.orst.edu>

(Just FYI, I already ACKed those patches, and I'll like them to go in
after some testing in -mm).
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
