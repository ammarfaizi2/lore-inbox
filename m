Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUDPPLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263308AbUDPPLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:11:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:9432 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263309AbUDPPLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:11:45 -0400
Message-Id: <200404161511.i3GFBX213703@mail.osdl.org>
Date: Fri, 16 Apr 2004 07:51:53 -0700 (PDT)
From: markw@osdl.org
Subject: Re: 2.6.5-mm5
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, mingo@elte.hu
In-Reply-To: <20040415124255.4bde2f1f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Apr, Andrew Morton wrote:
> Could we see 2.6.6-rc1 numbers please?

I have a result on ext2 with 2.6.6-rc1 that looks good:
	http://developer.osdl.org/markw/fs/dbt2_project_results.html

           ext2  ext3
2.6.6-rc1  2385
2.6.5-mm5  2165  1933
2.6.5-mm4  2180
2.6.5-mm3  2165  1930
2.6.5      2385

I'll run one for ext3 too.

Mark
