Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315210AbSFIVFp>; Sun, 9 Jun 2002 17:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSFIVFm>; Sun, 9 Jun 2002 17:05:42 -0400
Received: from holomorphy.com ([66.224.33.161]:22421 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315210AbSFIVFI>;
	Sun, 9 Jun 2002 17:05:08 -0400
Date: Sun, 9 Jun 2002 14:04:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: comments on adding slist.h
Message-ID: <20020609210452.GC22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas 'Dent' Mirlacher <dent@cosy.sbg.ac.at>,
	Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.05.10206091405450.16324-100000@mausmaki.cosy.sbg.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 02:09:57PM +0200, Thomas 'Dent' Mirlacher wrote:
> since we've already list.h, what about adding slist.h for
> single linked lists?
> single linked list are often used within the kernel,
> specifically slist_for_each() could be useful, since we can use
> prefetch() there.  (slist_for_each could be used 42 times alone net/core)
> any comments, (like, single linked lists are so trivial, there is no
> need for a header file. or, the programmer has to take care of using
> prefetch() when traversing single linked lists ...) are welcome.
> thanks,
> 	tm

This would be a valuable contribution.


Thanks,
Bill
