Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbULQMBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbULQMBN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbULQMBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:01:13 -0500
Received: from holomorphy.com ([207.189.100.168]:51411 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262789AbULQMBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:01:12 -0500
Date: Fri, 17 Dec 2004 04:00:54 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
Message-ID: <20041217120054.GT771@holomorphy.com>
References: <20041213020319.661b1ad9.akpm@osdl.org> <20041215113515.GJ771@holomorphy.com> <20041215034239.2d2f9d9d.akpm@osdl.org> <20041217025127.GP771@holomorphy.com> <20041216235505.3eaad88c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216235505.3eaad88c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> The odd userspace programs failing are far more disturbing. They
>> suggest COW or something of similar gravity is broken on x86-64
>> by some new patch. The ioremap/pageattr issues are merely some
>> shutdown-time oops, which is rather minor in comparison, although
>> reported far more verbosely.

On Thu, Dec 16, 2004 at 11:55:05PM -0800, Andrew Morton wrote:
> Oh, I missed that.  Did you apply the ioctl fix?

Seems unlikely to be related, but I'll try it.


-- wli
