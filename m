Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTD1O7u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbTD1O7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:59:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:7062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261159AbTD1O7t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:59:49 -0400
Message-ID: <3EAD44BF.30808@gmx.net>
Date: Mon, 28 Apr 2003 17:11:59 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de>
In-Reply-To: <20030428141023.GC4525@Wotan.suse.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > Linux supports up to 4 GB (~2^32 bytes) of memory on 32-bit
> > architectures and 64 GB (~2^36 bytes) on x86 with PAE. No other
> 
> 
> That's far too optimistic. 64GB will need patches, like the pgcl 
> patch. It is unlikely to work out of the box. Just do the math.

[explanatory math snipped]

> Realistic limit currently is ~16GB with an IA32 box.  For more you need

<marketingspeak>
This means ~16GB is available on IA32 right now with vanilla kernels,
and 64GB is available from vendors who are willing to apply the pgcl
patch. Conclusion: Linux supports 64GB on IA32
</marketingspeak>

> an 64bit architecture.

> > On 64-bit systems, Linux supports up to 16 EB (~2^64 bytes) of memory

That statement is OK?


Thanks,
Carl-Daniel
-- 
http://www.hailfinger.org/

