Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263710AbVBDMyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbVBDMyh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264369AbVBDMyh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:54:37 -0500
Received: from one.firstfloor.org ([213.235.205.2]:56040 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S263710AbVBDMvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:51:06 -0500
To: fabbione@fabbione.net (Fabio Massimo Di Nitto)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: parse noexec=[on|off]
References: <20050204093214.9DBB81EBF6@trider-g7.fabbione.net>
From: Andi Kleen <ak@muc.de>
Date: Fri, 04 Feb 2005 13:51:02 +0100
In-Reply-To: <20050204093214.9DBB81EBF6@trider-g7.fabbione.net> (Fabio
 Massimo Di Nitto's message of "Fri,  4 Feb 2005 10:32:14 +0100 (CET)")
Message-ID: <m1is58v689.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fabbione@fabbione.net (Fabio Massimo Di Nitto) writes:

> Hi,
>   the patch fixes the noexec= boot option on x86_64 to actually work when other
> options come after it.
>
> Credits (if any ;)) should go to Matt Zimmerman and Colin Watson for spotting
> the problem and providing/testing the fix.

Thanks merged and I audited the other early options. 

Please send all future x86-64 patches directly to me.


-Andi

