Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbTJJGdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 02:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbTJJGdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 02:33:52 -0400
Received: from mail.storm.ca ([209.87.239.66]:62147 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id S262525AbTJJGdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 02:33:51 -0400
Message-ID: <3F865376.2030103@storm.ca>
Date: Fri, 10 Oct 2003 14:36:38 +0800
From: Sandy Harris <sandy@storm.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
References: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de>	<20030930120629.GM2908@suse.de> <20030930052817.0d0272df.davem@redhat.com>
In-Reply-To: <20030930052817.0d0272df.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>>... when did the kernel/user interface break, and how?
> 
> 
> I'll answer for him, about 20 or 30 times during IPSEC development.
> ...

Natural enough.

> But that's not the important issue, the important issue is that
> a huge number of kernel API interfaces have no equivalent in
> whatever you consider to be "user usable non-kernel headers".
> 
> Find me the API defines for the IPSEC configuration socket interfaces
> in a header file that you think users should be allowed to include.
> 
> You won't find it Jens,

That is, you and the other IPsec developers did not create it.
I wonder why not.

 From my rather naive perspective, I would think providing header
files for whatever interface you provide is part of the job. Of
course they'd have to be user-includable and documented at least
in man pages.

I suspect I am missing something here. What?

> and that's why it drives me nuts when people
> spit out the "no kernel headers" mantra.  Often it simply must be
> done as a matter of practicality.




