Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263793AbTL2SkJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTL2SkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:40:09 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:41711 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S263937AbTL2SkF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:40:05 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Leon Toh <tltoh@attglobal.net>
Cc: sflory@rackable.com, Linux Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 29 Dec 2003 03:40:54 -0800 (PST)
Subject: Re: Adaptec/DPT I2O Option Omitted From Linux 2.6.0 Kernel 
 Configuration Tool
In-Reply-To: <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
Message-ID: <Pine.LNX.4.58.0312290340010.3163@dlang.diginsite.com>
References: <6.0.1.1.2.20031227093632.0229afe8@wheresmymailserver.com>
 <3FEF721D.7020405@rackable.com> <6.0.1.1.2.20031229201602.021feec0@mail.optusnet.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003, Leon Toh wrote:

> By the way I've hack the script file to make Adaptec I2O Option to appear
> in Linux 2.6.0 Kernel Configuration tool. Currently I'm now in the middle
> of recompiling the kernel using current dpti2o driver support but haven't
> got to the dpti2o driver yet.

did you doublecheck that it wasn't just blocked by not choosing to allow
you to compile known broken drivers?

David Lang

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
