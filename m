Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbUDDCE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 21:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUDDCE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 21:04:27 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:14790 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262109AbUDDCE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 21:04:26 -0500
Date: Sat, 3 Apr 2004 21:04:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andrew Morton <akpm@osdl.org>
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] early_param console_setup clobbers commandline
In-Reply-To: <20040403170851.4de81c72.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0404032103510.16677@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0404022026560.11690@montezuma.fsmlabs.com>
 <20040403030537.GF31152@smtp.west.cox.net> <Pine.LNX.4.58.0404031028090.11690@montezuma.fsmlabs.com>
 <20040403201450.GG31152@smtp.west.cox.net> <20040403122252.5b0dba14.akpm@osdl.org>
 <Pine.LNX.4.58.0404031958450.16677@montezuma.fsmlabs.com>
 <20040403170851.4de81c72.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Andrew Morton wrote:

> If it is still relevant and if the bug which it fixes is still present, yes
> please.  I plonked my current rollup against rc3 at
> http://www.zip.com.au/~akpm/linux/patches/stuff/z.gz.  I think it compiles ;)

It's taken care of in that rollup.

Thanks
