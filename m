Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268653AbRG3WQ1>; Mon, 30 Jul 2001 18:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268642AbRG3WQR>; Mon, 30 Jul 2001 18:16:17 -0400
Received: from suntan.tandem.com ([192.216.221.8]:7094 "EHLO suntan.tandem.com")
	by vger.kernel.org with ESMTP id <S267023AbRG3WQM>;
	Mon, 30 Jul 2001 18:16:12 -0400
Message-ID: <3B65DA0E.9736346D@compaq.com>
Date: Mon, 30 Jul 2001 15:05:02 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>, Larry McVoy <lm@bitmover.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Richard Guenther <rguenth@tat.physik.uni-tuebingen.de>,
        Andi Kleen <ak@suse.de>, Bill Pringlemeir <bpringle@sympatico.ca>
Subject: Re: [PATCH 2.4.7] generic hash table implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> Thanks to everyone who participated in the 'Common hash table implementation'
> thread. With your comments in mind, I molded Richard's code into something
> that might work for the kernel community (and Linus).
> 
> Included in the following patch are the generic hash implementation,
> documentation, and some test code. The test code will be stripped out when
> it's time to submit the patch for inclusion. To turn on the test code, set
> HASH_TEST to 1.
> 
> Before submitting, we probably want to port one or more kernel hash tables
> onto the generic implementation. I was thinking about porting the dcache
> sometime next week if I have time, then running it on my laptop to see if
> there's any problems.
> 
> Let me know what you think.
> 


Sorry. My last message had a bogus reply address (bwatson@sandbass.cpqcorp.net). I'm used to using Netscape mail, but since Netscape has no good
way to send inline patches unscathed, I used the mail command. I forgot that mail wouldn't know to use my correct reply address, and instead
would use the account name on my laptop.

To make a long story short, my correct reply address is Brian.J.Watson@compaq.com. Please copy me if you have comments about my adaptation of
Richard's generic hash implementation.

-- 
Brian Watson                | "The common people of England... so 
Linux Kernel Developer      |  jealous of their liberty, but like the 
Open SSI Clustering Project |  common people of most other countries 
Compaq Computer Corp        |  never rightly considering wherein it 
Los Angeles, CA             |  consists..."
                            |     -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
