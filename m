Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbTCPISV>; Sun, 16 Mar 2003 03:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262595AbTCPISV>; Sun, 16 Mar 2003 03:18:21 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:22912 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S262584AbTCPISV>; Sun, 16 Mar 2003 03:18:21 -0500
Date: Sun, 16 Mar 2003 00:29:11 -0800
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.64-mjb4 (scalability / NUMA patchset)
Message-ID: <20030316082911.GA777@gnuppy.monkey.org>
References: <169550000.1046895443@[10.10.2.4]> <475260000.1047172886@[10.10.2.4]> <85960000.1047532556@[10.10.2.4]> <10770000.1047787269@[10.10.2.4]> <20030316044524.GA6757@gnuppy.monkey.org> <12150000.1047793549@[10.10.2.4]> <20030316063151.GA7114@gnuppy.monkey.org> <19840000.1047797300@[10.10.2.4]> <20030316065650.GA8164@gnuppy.monkey.org> <20280000.1047798483@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20280000.1047798483@[10.10.2.4]>
User-Agent: Mutt/1.5.3i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 15, 2003 at 11:08:04PM -0800, Martin J. Bligh wrote:
> What happens if you turn this bit off ?
> CONFIG_DEBUG_SLAB=y

Well, uh, now it just flat out hangs right after it decompresses
the kernel image. I've got an "Intel i815EEA" here, pure UP. Hmmm.

bill

