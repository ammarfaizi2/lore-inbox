Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266997AbSKSPb0>; Tue, 19 Nov 2002 10:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266995AbSKSPb0>; Tue, 19 Nov 2002 10:31:26 -0500
Received: from franka.aracnet.com ([216.99.193.44]:23451 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S266997AbSKSPb0>; Tue, 19 Nov 2002 10:31:26 -0500
Date: Tue, 19 Nov 2002 07:35:18 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: vasya vasyaev <vasya197@yahoo.com>, Andrew Morton <akpm@digeo.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
Message-ID: <788336908.1037691317@[10.10.2.3]>
In-Reply-To: <20021119092912.39541.qmail@web20510.mail.yahoo.com>
References: <20021119092912.39541.qmail@web20510.mail.yahoo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Box has 1 GB of RAM, it's running oracle database.
> After some disk activity disk cache has 400 Mb, so 600
> Mb is free

What makes you assume that the only thing taking up RAM
in the whole box is disk cache? 1GB of ram with 400Mb
of disk cache != 600Mb free. Posting /proc/meminfo is
likely to be more revealing.

M.

