Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269297AbUIICBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269297AbUIICBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 22:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269329AbUIICBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 22:01:10 -0400
Received: from holomorphy.com ([207.189.100.168]:59564 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269297AbUIICBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 22:01:08 -0400
Date: Wed, 8 Sep 2004 19:01:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <20040909020105.GP3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040907020831.62390588.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907020831.62390588.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
> - Added Dave Howells' mysterious CacheFS.
> - Various new fixes, cleanups and bugs, as usual.

So far so good with minimal patchwerk on ia64, and sparc64. ppc64 comes
up but the JS20 tg3 issues are still biting me and the backout patches
I was using don't apply anymore.


-- wli
