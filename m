Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUKICb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUKICb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 21:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbUKICb1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 21:31:27 -0500
Received: from smtp1.ensim.com ([65.164.64.254]:57967 "EHLO smtp1.ensim.com")
	by vger.kernel.org with ESMTP id S261347AbUKICb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 21:31:26 -0500
From: Borislav Deianov <borislav@users.sourceforge.net>
Date: Mon, 8 Nov 2004 18:31:19 -0800
To: Chris Wright <chrisw@osdl.org>
Cc: len.brown@intel.com, Karsten Wiese <annabellesgarden@yahoo.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] ibm-acpi-0.8 (was Re: 2.6.10-rc1-mm3)
Message-ID: <20041109023119.GB21832@aero.ensim.com>
References: <200411081334.18751.annabellesgarden@yahoo.de> <200411082240.02787.annabellesgarden@yahoo.de> <20041108153022.N14339@build.pdx.osdl.net> <20041109013013.GA21832@aero.ensim.com> <20041108181224.F2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108181224.F2357@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-OriginalArrivalTime: 09 Nov 2004 02:30:26.0859 (UTC) FILETIME=[12AB1FB0:01C4C604]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 06:12:24PM -0800, Chris Wright wrote:
> 
> Ah, even better.  Thanks Boris.  BTW, you could probably mark ibm_init()
> and ibm_handle_init() as __init.

Good point, I'll do it in the next version.

Thanks,
Boris
