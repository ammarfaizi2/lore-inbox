Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268696AbRGZVfX>; Thu, 26 Jul 2001 17:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268638AbRGZVfN>; Thu, 26 Jul 2001 17:35:13 -0400
Received: from suntan.tandem.com ([192.216.221.8]:29620 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S268696AbRGZVfG>; Thu, 26 Jul 2001 17:35:06 -0400
Message-ID: <3B6089D0.BC6F5770@compaq.com>
Date: Thu, 26 Jul 2001 14:21:20 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.4.7] enabling RWSEM_DEBUG
In-Reply-To: <1722.996164012@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

David Howells wrote:
> 
> > Unfortunately, I ran into a bug with enabling RWSEM_DEBUG. The bug
> still
> > exists in 2.4.7.
> 
> Could you try applying the attached patch, please.
> 
> David
> 

It builds beautifully now. Thanks. I'll move forward with my contention test.

-- 
Brian Watson                | "The common people of England... so 
Linux Kernel Developer      |  jealous of their liberty, but like the 
Open SSI Clustering Project |  common people of most other countries 
Compaq Computer Corp        |  never rightly considering wherein it 
Los Angeles, CA             |  consists..."
                            |     -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
