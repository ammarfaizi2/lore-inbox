Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTIJKCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 06:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbTIJKCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 06:02:05 -0400
Received: from zork.zork.net ([64.81.246.102]:27884 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S261492AbTIJKCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 06:02:03 -0400
To: "Amir Hermelin" <amir@montilio.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4 page cache procedures
References: <002401c37785$e22c5de0$0401a8c0@CARTMAN>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: "Amir Hermelin" <amir@montilio.com>,
 <linux-kernel@vger.kernel.org>
Date: Wed, 10 Sep 2003 11:01:55 +0100
In-Reply-To: <002401c37785$e22c5de0$0401a8c0@CARTMAN> (Amir Hermelin's
 message of "Wed, 10 Sep 2003 12:25:29 +0200")
Message-ID: <6uhe3lotbg.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Amir Hermelin" <amir@montilio.com> writes:

> I've looked all over, but haven't been able to find a good description of
> the 2.4 page cache procedures (not mmap() system call, but rather for kernel
> programming).  There's a description in the Linux Kernel 2.4 internals, but
> it's somewhat missing some details.
>
> Anyone got a good online reference, would be greatly appreciated.

Mel Gorman's VM docs may be what you seek.

http://www.csn.ul.ie/~mel/projects/vm/

