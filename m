Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263012AbTJPPKX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 11:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263069AbTJPPKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 11:10:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12958 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263012AbTJPPKU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 11:10:20 -0400
Message-ID: <3F8EB4CD.8050205@pobox.com>
Date: Thu, 16 Oct 2003 11:10:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eli Billauer <eli_billauer@users.sf.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <3F8E8EA8.8030707@users.sf.net>
In-Reply-To: <3F8E8EA8.8030707@users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Billauer wrote:
> My argument, possibly better formulated, asks the following questions:
> 
> (1) How much good will the existence of an standard /dev/frandom device 
> do? Is it going to be used?
> (2) How much space will it take up in the kernel tarball?
> (3) How much disk space will it take after compilation?
> (4) How much compilation time will it take up?
> (5) How much effort is it going to be to maintain it?
[...]
> I actually agree that the kernel isn't "the right place" for a random 
> generator. I simply think that having it there is useful, with a very 
> low cost.


Add up 1000 low-cost items, and you can run a catalog store...  but not 
a kernel.

None of those questions 1-5 make much bit of difference:  The key 
question is "right place", and you just agreed w/ me the kernel isn't :)

	Jeff



