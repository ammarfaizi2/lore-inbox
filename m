Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTKJCiw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 21:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTKJCiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 21:38:52 -0500
Received: from terminus.zytor.com ([63.209.29.3]:15506 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261687AbTKJCiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 21:38:51 -0500
Message-ID: <3FAEFA2F.8040509@zytor.com>
Date: Sun, 09 Nov 2003 18:38:39 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en, sv, es, fr
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
References: <20031107051048.GA6099@work.bitmover.com> <bollnv$uvt$1@cesium.transmeta.com> <20031109152534.GA24312@work.bitmover.com> <3FAE9576.9080007@zytor.com> <20031110015905.GN13246@waste.org>
In-Reply-To: <20031110015905.GN13246@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:
> 
> Except for the higher likelihood of pserver being an exploit vector.
> 

True... for that it would be nice to have the pserver run in an isolated 
environment (separate server, UML, ...) on a copy of the tree.  That's 
more work, though...

	-hpa

