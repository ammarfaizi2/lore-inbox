Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267666AbUBRRz5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 12:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267668AbUBRRz5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 12:55:57 -0500
Received: from mail6.fw-bc.sony.com ([160.33.98.73]:3570 "EHLO
	mail6.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S267666AbUBRRzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 12:55:55 -0500
Message-ID: <4033A91B.3030801@am.sony.com>
Date: Wed, 18 Feb 2004 10:04:11 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Andrew Morton <akpm@osdl.org>, paulmck@us.ibm.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
References: <1077108694.4479.4.camel@laptop.fenrus.com>
In-Reply-To: <1077108694.4479.4.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should know better than to stir up a hornets nest
by discussing GPL issues on this list... :)

Arjan van de Ven wrote:
> On Wed, 2004-02-18 at 01:19, Andrew Morton wrote:
>>Neat, but it's hard to see the relevance of this to your patch.
>>I don't see any licensing issues with the patch because the filesystem
>>which needs it clearly meets Linus's "this is not a derived work"
>>criteria.
> 
> it does?
...
> it needs no changes to the core kernel? *buzz*
Actually, this would tend towards an interpretation that
it was NOT a derived work.

That is, if a the Linux kernel must be modified in order
to run with a piece of software, that's one indicator
that the piece of software (when standing alone) may not
be derived from the kernel.  I am purposely avoiding the
"but what about when it's linked" argument.

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

