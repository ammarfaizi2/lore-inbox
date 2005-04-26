Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVDZP3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVDZP3I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261576AbVDZP3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:29:07 -0400
Received: from darwin.snarc.org ([81.56.210.228]:7823 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261579AbVDZP0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:26:40 -0400
Date: Tue, 26 Apr 2005 17:26:38 +0200
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, ian.pratt@cl.cam.ac.uk, akpm@osdl.org
Subject: Re: [PATCH 5/6][XEN][x86_64] Add macro for debugreg
Message-ID: <20050426152638.GA23714@snarc.org>
References: <20050426113149.GE26614@snarc.org> <20050426131707.GB5098@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426131707.GB5098@wotan.suse.de>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:17:07PM +0200, Andi Kleen wrote:
> It looks good, except that the name of the macro is too long.
> I will queue it and fix the name up when I apply. 

fine. let me know the new name, I'll regenerate a new set of patch for
x86 too. It's probably better to have the same name between the 2 archs.

> If you plan to add a lot more of these I would recommend
> to create a new header first, processor.h is already quite crowded.

Right. Although I think that's all (at least at the moment).
I'll consider that anyway, if more shows up. 

Thanks,
-- 
Vincent Hanquez
