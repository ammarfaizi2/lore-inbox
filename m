Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbTDFPrM (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTDFPrM (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:47:12 -0400
Received: from node181b.a2000.nl ([62.108.24.27]:10130 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id S263013AbTDFPrL (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 11:47:11 -0400
Date: Sun, 6 Apr 2003 17:56:17 +0200 (CEST)
From: Stephan van Hienen <raid@a2000.nu>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: tuning disk on 3ware /performance problem
In-Reply-To: <200304061131_MC3-1-333A-E630@compuserve.com>
Message-ID: <Pine.LNX.4.53.0304061755230.16453@ddx.a2000.nu>
References: <200304061131_MC3-1-333A-E630@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Apr 2003, Chuck Ebbert wrote:

>
>
>
> > Is there anything i can do to tune the drives connected to he 3ware
> > controller ? (37MB/sec vs 43MB/sec) (and why is the seq. output block
> > 65MB/sec on the 3ware vs 41MB/sec on 'ide controllers')
>
>
> Try doing a real test with a 1 GB file on an empty filesystem:

sure, but that is what bonnie is also doing...
