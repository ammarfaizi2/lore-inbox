Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269190AbUIICaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269190AbUIICaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 22:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269220AbUIICaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 22:30:11 -0400
Received: from holomorphy.com ([207.189.100.168]:7853 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269190AbUIICaI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 22:30:08 -0400
Date: Wed, 8 Sep 2004 19:30:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm4
Message-ID: <20040909023005.GQ3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040907020831.62390588.akpm@osdl.org> <20040909020105.GP3106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909020105.GP3106@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/
>> - Added Dave Howells' mysterious CacheFS.
>> - Various new fixes, cleanups and bugs, as usual.

On Wed, Sep 08, 2004 at 07:01:05PM -0700, William Lee Irwin III wrote:
> So far so good with minimal patchwerk on ia64, and sparc64. ppc64 comes
> up but the JS20 tg3 issues are still biting me and the backout patches
> I was using don't apply anymore.

x86-64 comes up fine as well.


-- wli
