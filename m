Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267799AbUHER3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267799AbUHER3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 13:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267797AbUHER3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 13:29:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:49848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267802AbUHER2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 13:28:04 -0400
Date: Thu, 5 Aug 2004 10:26:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: cciss update [1 of 6]
Message-Id: <20040805102626.0bcd3199.akpm@osdl.org>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DBFBA7@cceexc23.americas.cpqcorp.net>
References: <D4CFB69C345C394284E4B78B876C1CF107DBFBA7@cceexc23.americas.cpqcorp.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Miller, Mike (OS Dev)" <mike.miller@hp.com> wrote:
>
> Sorry, I thought the descriptions in the patch were sufficient. 

The descriptions are fine - I was just mentioning the email's Subject:
line.

> Again, I wish viro would copy me on patches to cciss. Isn't that the normal protocol, include the maintainer in any updates?

It tends to depend on the importance of the patch, the activity level of
the maintainer, etc.  If the patches are dependent on other patches to
other parts of the kernel then it's best that they all go in as a single
lump.  A courtesy Cc: never hurts, althought it's sometime hard to hunt
down the right person.

I have suffered some pain from the depredations of the sparse changes. 
Hopefully it's mostly all done now.
