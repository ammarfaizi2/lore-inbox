Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSLBRrE>; Mon, 2 Dec 2002 12:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSLBRrE>; Mon, 2 Dec 2002 12:47:04 -0500
Received: from franka.aracnet.com ([216.99.193.44]:4556 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264665AbSLBRrD>; Mon, 2 Dec 2002 12:47:03 -0500
Date: Mon, 02 Dec 2002 09:50:50 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Christoph Hellwig <hch@sgi.com>, marcelo@connectiva.com.br.munich.sgi.com,
       rml@tech9.net
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <1919608311.1038822649@[10.10.2.3]>
In-Reply-To: <20021202192652.A25938@sgi.com>
References: <20021202192652.A25938@sgi.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> now that all commercial vendors ship a backport of Ingo's O(1) 
> scheduler external projects like XFS have to track those projects 
> in addition to the mainline kernel.

There was talk of merging the O(1) scheduler into 2.4 at OLS.
If every distro has it, and 2.5 has it, and it's been around for
this long, I think that proves it stable.

Marcelo, what are the chances of getting this merged into mainline
in the 2.4.20 timeframe?

Thanks,

M.
