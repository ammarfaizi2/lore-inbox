Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTILJgq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTILJgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:36:46 -0400
Received: from pdbn-d9bb868d.pool.mediaWays.net ([217.187.134.141]:38929 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S261366AbTILJgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:36:45 -0400
Date: Fri, 12 Sep 2003 11:36:28 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Kyle Rose <krose+linux-kernel@krose.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large-file corruption. ReiserFS? VFS?
Message-ID: <20030912093628.GA29293@citd.de>
References: <87r82noyr9.fsf@nausicaa.krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r82noyr9.fsf@nausicaa.krose.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 04:28:58PM -0400, Kyle Rose wrote:
>  
> I don't have a large enough ext2/3 filesystem to compare with, so
> there's no easy way for me to tell whether this is a Reiser-only
> problem or not.  Can anyone confirm that they see the same problem, or
> whether they see a similar problem on another file system?  Please
> feel free to ask me for any other information you think might be
> illuminating.

I can only speak for 2.4-Kernel

I burn DVDs since more than 2 years now. Starting with 2.4.4 and i had
NEVER problems with the size, i never used the split-option of mkisofs
(and i don't even know the correct(tm) name of it. I only know that it
exists).
The maximum is 4489MB, (>4.700.000.000 bytes) and the biggest images i
had are only a few KB smaller that that.

Since about 2 month i use reiserfs on the "source" and on the
"target"-HDD. No changes, except that reiserfs is slower then ext2.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

