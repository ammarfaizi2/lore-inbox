Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbTIBAPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 20:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263371AbTIBAPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 20:15:15 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:1944 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S263362AbTIBAPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 20:15:10 -0400
Date: Tue, 2 Sep 2003 10:13:22 +1000
From: CaT <cat@zip.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Wes Janzen <superchkn@sbcglobal.net>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: -mm patches on www.kernel.org ?
Message-ID: <20030902001322.GA1286@zip.com.au>
References: <Pine.LNX.4.51.0308071636100.31463@dns.toxicfilms.tv> <20030901211108.GE31760@matchmail.com> <3F53B937.10103@sbcglobal.net> <20030901225339.GH31760@matchmail.com> <3F53DEE1.5000709@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F53DEE1.5000709@zytor.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 05:05:53PM -0700, H. Peter Anvin wrote:
> Mike Fedyk wrote:
> >On Mon, Sep 01, 2003 at 04:25:11PM -0500, Wes Janzen wrote:
> >
> >>I think he's saying, why not put a link to the mm kernels from the 
> >>www.kernel.org homepage, just like the ac kernels...  At least that's 
> >>how I read it.
> >
> >Ok, then I can agree with that.
> 
> Can't do it.  The -mm kernels aren't a single patch, they're patch sets, 
> and they won't work with the system that we have set up.  If akpm wants 
> to make a unified patch for each patch set in addition to the set itself 
> then it can be done.

AFAIK he does. I always apply a single patch. The individual patches
are in the break-out directory for easy viewing but the actual dir
contains the patch that contains all the break-out patches AFAIK.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
