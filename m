Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbUCXL1m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 06:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUCXL1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 06:27:42 -0500
Received: from colin2.muc.de ([193.149.48.15]:61705 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S263291AbUCXL1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 06:27:40 -0500
Date: 24 Mar 2004 12:27:39 +0100
Date: Wed, 24 Mar 2004 12:27:39 +0100
From: Andi Kleen <ak@muc.de>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Non-Exec stack patches
Message-ID: <20040324112739.GA64848@colin2.muc.de>
References: <1D3lO-3dh-13@gated-at.bofh.it> <1D3YZ-3Gl-1@gated-at.bofh.it> <m3n066eqbf.fsf@averell.firstfloor.org> <4061619F.4020704@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4061619F.4020704@stesmi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, there's also the case that (unknown if rumour or confirmed) there
> will be AthlonXPs based on the K8 core that do NOT run 64bit code.

Yes, you're right. Some HP laptops ship with such crippled chips. 

> I would THINK they would include the NX bit but that's just a guess of
> course.

Most likely yes. 

But who buys such crippled CPUs will have to live with that. Or do a patch.
NX support is mostly hype anyways, it doesn't give you much advantage.

-Andi
