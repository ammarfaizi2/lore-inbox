Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbTCOVHM>; Sat, 15 Mar 2003 16:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbTCOVHL>; Sat, 15 Mar 2003 16:07:11 -0500
Received: from holomorphy.com ([66.224.33.161]:18643 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261572AbTCOVHL>;
	Sat, 15 Mar 2003 16:07:11 -0500
Date: Sat, 15 Mar 2003 13:17:38 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] concurrent inode allocation for ext2 against 2.5.64
Message-ID: <20030315211738.GW20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>
References: <m365qk1gzx.fsf@lexa.home.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m365qk1gzx.fsf@lexa.home.net>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 16, 2003 at 12:01:38AM +0300, Alex Tomas wrote:
> here is the patch for ext2 concurrent inode allocation. should be applied
> on top of previous concurrent-balloc patch. tested on dual p3 for several
> hours of stress-test + fsck. hope someone test it on big iron ;)

benching now
