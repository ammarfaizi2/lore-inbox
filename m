Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTA1P5k>; Tue, 28 Jan 2003 10:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTA1P5k>; Tue, 28 Jan 2003 10:57:40 -0500
Received: from franka.aracnet.com ([216.99.193.44]:36228 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267356AbTA1P5j>; Tue, 28 Jan 2003 10:57:39 -0500
Date: Tue, 28 Jan 2003 08:06:48 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Jason Papadopoulos <jasonp@boo.net>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] page coloring for 2.5.59 kernel, version 1
Message-ID: <1466000000.1043770007@titus>
In-Reply-To: <20030128071313.GH780@holomorphy.com>
References: <3.0.6.32.20030127224726.00806c20@boo.net> <884740000.1043737132@titus> <20030128071313.GH780@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think this one really needs to be done with the userspace cache
> thrashing microbenchmarks. 

If a benefit cannot be show on some sort of semi-realistic workload,
it's probably not worth it, IMHO.

M.

