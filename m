Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266898AbUHCWEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266898AbUHCWEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUHCWEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 18:04:12 -0400
Received: from adsl-68-95-0-242.dsl.rcsntx.swbell.net ([68.95.0.242]:29572
	"EHLO arion.soze.net") by vger.kernel.org with ESMTP
	id S266898AbUHCWDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 18:03:51 -0400
Date: Tue, 3 Aug 2004 22:03:41 +0000
From: Justin Guyett <justin@soze.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Hibbard.Smith@nasdaq.com
Subject: Re: mainline i2o issues with adaptec raid (was: i2o and adaptec raid)
Message-ID: <20040803220341.GA6010@arion.soze.net>
References: <20040803050223.GB2295@arion.soze.net> <20040802230931.04c0769d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040802230931.04c0769d.akpm@osdl.org>
X-PGP-Fingerprint: 9AE2 9FC3 D98B 9AE2 EE83  15CC 9C7D 1925 4568 5243
X-Hashcash: 0:040803:akpm@osdl.org:b791745e5091adb4af51fa75
X-Hashcash: 0:040803:linux-kernel@vger.kernel.org:b4ed16d2ac8ae5d65f95f1ad
X-Hashcash: 0:040803:hibbard.smith@nasdaq.com:e19da3119c73211eec300535
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-08-02T23:09:31-0700, Andrew Morton wrote:
> By reading your .config I was able to divine that you're running some 2.6
> kernel ;)
> 
> There's an i2o rewrite in
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.8-rc2/2.6.8-rc2-mm2/2.6.8-rc2-mm2.gz
> - testing of that would be appreciated.

Build 103 (2.6.8-rc2-mm2) succeeds where mainline 2.6.8-rc2-bk12 i2o
(adaptec 2110s) failed.

8 concurrent 6-GB bonnie++ runs also succeed.

-- 
"When in our age we hear these words: It will be judged by the result--then we
know at once with whom we have the honor of speaking.  Those who talk this way
are a numerous type whom I shall designate under the common name of assistant
professors."  -- Kierkegaard, Fear and Trembling (Wong tr.), III, 112

