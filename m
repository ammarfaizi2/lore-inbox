Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbUCJSKv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 13:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUCJSIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 13:08:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24468 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262748AbUCJSHb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 13:07:31 -0500
Message-ID: <404F5955.6040702@pobox.com>
Date: Wed, 10 Mar 2004 13:07:17 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Christoph Hellwig <hch@infradead.org>, prism54-devel@prism54.org,
       "David S. Miller" <davem@redhat.com>, netdev@oss.sgi.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Intersil Prism54 wireless driver
References: <20040304023524.GA19453@bougret.hpl.hp.com> <20040310165548.A24693@infradead.org> <20040310172114.GA8867@bougret.hpl.hp.com>
In-Reply-To: <20040310172114.GA8867@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> On Wed, Mar 10, 2004 at 04:55:48PM +0000, Christoph Hellwig wrote:
> 
>>On Wed, Mar 03, 2004 at 06:35:24PM -0800, Jean Tourrilhes wrote:
>>
>>>	Hi Dave & Jeff,
>>>
>>>	The attached .bz2 file is a patch for 2.6.3 adding the
>>>Intersil Prism54 wireless driver. Sorry for the attachement, the file
>>>is rather big, if you want inline+plaintext, I'll send that personal
>>>to you.
>>>	I've been using this driver with great success on 2.6.3 and
>>>2.6.4-rc1 (SMP). This driver support various popular CardBus and PCI
>>>802.11g cards (54 Mb/s) based on the Intersil PrismGT/PrismDuette
>>>chipset.
>>>	I would like this driver to go into 2.6.X. However, I
>>>understand that it's lot's of code to review.
>>
>>Here's a few things I found.
> 
> 
> 	I'm forwarding to prism54-devel where the real developpers can
> answer your questions.

since I'm not on the this list, I am getting a bunch of "your message 
for prism54-devel awaits moderator approval" responses.

Maybe the prism54 and hostAP developers could join us on netdev?  It 
would be nice to have everybody in one place, if we're all gonna be 
collaborating on a generic 802.11 stack.

	Jeff



