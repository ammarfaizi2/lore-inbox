Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbUJ1PYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbUJ1PYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUJ1PWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:22:21 -0400
Received: from holomorphy.com ([207.189.100.168]:21897 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261692AbUJ1PTX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:19:23 -0400
Date: Thu, 28 Oct 2004 08:19:19 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: sparc ffb drm driver...
Message-ID: <20041028151919.GN12934@holomorphy.com>
References: <Pine.LNX.4.58.0410281222450.15369@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410281222450.15369@skynet>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 12:38:08PM +0100, Dave Airlie wrote:
> This driver is broken and has been since my first CVS merge went in
> back in April, I just noticed there now when trying to fix it up for
> some other changes that I was making,
> List of issues:
> a) no-one has complained or noticed it has been broken for at least 4
> months
> b) there is no current user space to go with the kernel space driver (Mesa
> DRI driver is broken as far as I know....)
> c) no-one has stepped up to maintain it
> d) no-one has a working user space to tell me I broke the kernel space or
> test it for me ..
> Unless we can up with some plan for the future (user and kernel space),
> this driver will be marked broken in my next merge and may in fact end
> up broken as a side effect of the changes for the core/personality split..
> Dave.
> p.s. I'd love to take it on, but I've no sparc hardware and no real spare
> time even if I had...

I think all my sparc32 and UltraSPARC hardware is too ancient or crappy
to help with this, at the very least because it's all headless.

-- wli
