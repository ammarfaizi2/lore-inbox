Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbTKNHUN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 02:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbTKNHUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 02:20:13 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:42454 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S262188AbTKNHUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 02:20:11 -0500
Date: Thu, 13 Nov 2003 21:07:30 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Message-ID: <3210000.1068786449@[10.10.2.4]>
In-Reply-To: <20031112233002.436f5d0c.akpm@osdl.org>
References: <20031112233002.436f5d0c.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - Several ext2 and ext3 allocator fixes.  These need serious testing on big
>   SMP.

Survives kernbench and SDET on ext2 at least on 16-way. I'll try ext3
later.

M.
