Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265570AbTF2E0j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 00:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265576AbTF2E0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 00:26:39 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:11966 "EHLO
	rwcrmhc13.attbi.com") by vger.kernel.org with ESMTP id S265570AbTF2E0f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 00:26:35 -0400
Message-ID: <3EFE70E1.7020205@kegel.com>
Date: Sat, 28 Jun 2003 21:53:53 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: How to Avoid GPL Issue
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

GC wrote:
> We are trying to port a third party hardware driver into Linux kernel and 
> this third party vendor does not allow us to publish the source code. Is 
> there any approach that we can avoid publicizing the third party code while 
> porting to Linux? Do we need to write some shim layer code in Linux kernel 
> to interface the third party code? How can we do that? Is there any document 
> or samples?

Xose replied:
> You should begin reading 'Proprietary kernel modules' at
> http://people.redhat.com/rkeech/pkm.html

That's a very good summary.  Xose pointed you to the right place, GC.

Practically speaking, you can probably do what Nvidia does,
but nobody on this list will support users who run into
trouble loading your kernel module.

In other words, you may not in fact be able to avoid the GPL issue...
sorry...
- Dan

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

