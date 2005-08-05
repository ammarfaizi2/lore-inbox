Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVHEWj0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVHEWj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 18:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVHEWjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 18:39:25 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:17931 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S262006AbVHEWik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 18:38:40 -0400
Date: Fri, 5 Aug 2005 18:38:31 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Andreas Steinmetz <ast@domdv.de>
cc: Andrew Morton <akpm@osdl.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>, pavel@suse.cz,
       davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
In-Reply-To: <42F34022.9040201@domdv.de>
Message-ID: <Pine.LNX.4.61.0508051835210.28261@lancer.cnet.absolutedigital.net>
References: <42DD67D9.60201@stud.feec.vutbr.cz> <20050804142548.5b813700.akpm@osdl.org>
 <Pine.LNX.4.61.0508041741540.4557@lancer.cnet.absolutedigital.net>
 <42F34022.9040201@domdv.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Aug 2005, Andreas Steinmetz wrote:

> AFAIK it works when agp is built into the kernel. You will get problems
> when it is built as a module. In the module case you may want to try if
> loading the module before resuming helps.

Strange. I've had it built as a module from day one and never had a 
problem resuming.

-cp

-- 
"There are three kinds of lies: lies, damned lies, and statistics."
                     -- Benjamin Disraeli

