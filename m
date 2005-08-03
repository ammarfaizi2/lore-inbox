Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVHCOZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVHCOZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVHCOZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 10:25:47 -0400
Received: from cantor2.suse.de ([195.135.220.15]:18063 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261894AbVHCOZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 10:25:28 -0400
Date: Wed, 3 Aug 2005 16:25:19 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       adaplas@gmail.com, adaplas@pol.net, ak@suse.de
Subject: Re: vesafb-fix-mtrr-bugs.patch added to -mm tree
Message-ID: <20050803142517.GY10895@wotan.suse.de>
References: <200507291825.j6TIParH012406@shell0.pdx.osdl.net> <20050729185848.GP17003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729185848.GP17003@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The pains of MTRR strike again. This stuff is just screaming for
> a usable PAT implementation. Andi, you were working on that, any news ?

No news yet, but work will hopefully start soon.

> Or should I resurrect Terrence's patch again ?

Perhaps useful for some preliminary testing.

-Andi
