Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVD0NFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVD0NFD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 09:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261591AbVD0NFD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 09:05:03 -0400
Received: from ns.suse.de ([195.135.220.2]:33427 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261578AbVD0NFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 09:05:00 -0400
Date: Wed, 27 Apr 2005 15:04:59 +0200
From: Andi Kleen <ak@suse.de>
To: Vincent Hanquez <tab@snarc.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       ian.pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [PATCH 5/6][XEN][x86_64] Add macro for debugreg
Message-ID: <20050427130459.GI13305@wotan.suse.de>
References: <20050426113149.GE26614@snarc.org> <20050426131707.GB5098@wotan.suse.de> <20050426152638.GA23714@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426152638.GA23714@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 05:26:38PM +0200, Vincent Hanquez wrote:
> On Tue, Apr 26, 2005 at 03:17:07PM +0200, Andi Kleen wrote:
> > It looks good, except that the name of the macro is too long.
> > I will queue it and fix the name up when I apply. 
> 
> fine. let me know the new name, I'll regenerate a new set of patch for
> x86 too. It's probably better to have the same name between the 2 archs.

Just dropping the cpu_ should be enough.

-Andi
