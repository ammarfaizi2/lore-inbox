Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264090AbTDWP1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 11:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTDWP1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 11:27:01 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:16862 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264090AbTDWPZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 11:25:29 -0400
Date: Wed, 23 Apr 2003 17:37:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Newest Ext3 code for 2.4.x
Message-ID: <20030423153724.GA503@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've found a reproducable bug in ext3 on my notebook. This gets hit
under 2.4.19-ac4 and 2.4.20.1 (or whatever you want to call the
patches from hardrock.org).

Before I dive into the code, what is the most recent ext3 code that I
could update to? 2.4.21-rc1? Are any of the patches from
http://www.zip.com.au/~akpm/linux/patches/2.4/2.4.20/ missing? Is
there more unreleased code?

Jörn

-- 
To announce that there must be no criticism of the President, or that we
are to stand by the President, right or wrong, is not only unpatriotic
and servile, but is morally treasonable to the American public.
-- Theodore Roosevelt, Kansas City Star, 1918

