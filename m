Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263193AbUDEUxe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 16:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263195AbUDEUxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 16:53:34 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:58121 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263193AbUDEUxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 16:53:30 -0400
Message-ID: <4071CC1F.4000502@techsource.com>
Date: Mon, 05 Apr 2004 17:14:07 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Sergiy Lozovsky <serge_lozovsky@yahoo.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405175940.94093.qmail@web40509.mail.yahoo.com> <200404051927.i35JR2EN017101@turing-police.cc.vt.edu>
In-Reply-To: <200404051927.i35JR2EN017101@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Valdis.Kletnieks@vt.edu wrote:

> 
> So you're including a much bigger interface for little gain.  The total
> footprint of the two solutions is about the same, but SELinux the vast majority
> of it is in userspace, and only costs you when you're actually compiling/
> loading a new policy, whereas yours takes up 100K of kernel space all the
> time....
> 


The key concept here is "in userspace".

