Return-Path: <linux-kernel-owner+w=401wt.eu-S965476AbWLPRl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965476AbWLPRl3 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965478AbWLPRl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:41:29 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:53528 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965476AbWLPRl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:41:28 -0500
Date: Sat, 16 Dec 2006 09:39:49 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Ondrej Zajicek <santiago@crfreenet.org>,
       linux-kernel@vger.kernel.org, James Simmons <jsimmons@infradead.org>,
       adaplas@pol.net
Subject: Re: [-mm patch] drivers/video/{s3fb,svgalib}.c: possible cleanups
Message-Id: <20061216093949.9f58e347.randy.dunlap@oracle.com>
In-Reply-To: <20061216135657.GC3388@stusta.de>
References: <20061214225913.3338f677.akpm@osdl.org>
	<20061216135657.GC3388@stusta.de>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 14:56:57 +0100 Adrian Bunk wrote:

> This patch contains the following possible cleanups:
> - CodingStyle:
>   - opening braces of functions at the beginning of the next line
>   - C99 struct initializers

I don't see anything about struct initializers in CodingStyle,
but I would say that it's a good candidate for addition.

---
~Randy
