Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVC2Hy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVC2Hy1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 02:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVC2Hv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 02:51:27 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2764 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262590AbVC2HpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 02:45:00 -0500
Message-ID: <42490763.5010008@pobox.com>
Date: Tue, 29 Mar 2005 02:44:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, netdev@oss.sgi.com
Subject: Re: [PATCH] s390: claw network device driver
References: <200503290533.j2T5XEYT028850@hera.kernel.org>	<4248FBFD.5000809@pobox.com>	<20050328230830.5e90396f.akpm@osdl.org>	<20050329071210.GA16409@havoc.gtf.org> <20050328232359.4f1e04b9.akpm@osdl.org>
In-Reply-To: <20050328232359.4f1e04b9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>> > Was cc'ed to linux-net last Thursday, but it looks like the messages was
>> > too large and the vger server munched it.
>>
>> This also brings up a larger question... why was a completely unreviewed
>> net driver merged?
> 
> 
> Because nobody noticed that it didn't make it to the mailing list,
> obviously.

That's ducking the question.  Let me rephrase.

Why was a complete lack of response judged to be an ACK?

For new drivers, that's a -horrible- precedent.  You are quite skilled 
at poking random hackers :)  why not poke somebody to ack a new drivers? 
  It's not like this driver (or many of the other new drivers) 
desperately need to get into the kernel ASAP, so desperate that a lack 
of review was OK.

	Jeff


