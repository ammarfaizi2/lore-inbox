Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286219AbRLTMLs>; Thu, 20 Dec 2001 07:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbRLTMLk>; Thu, 20 Dec 2001 07:11:40 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:3450 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S286219AbRLTMLa>;
	Thu, 20 Dec 2001 07:11:30 -0500
Message-ID: <3C21D50C.5020605@debian.org>
Date: Thu, 20 Dec 2001 13:09:48 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: proposal: feed smaller mailing lists into linux-kernel, addlinux-kernel-core and linux-kernel-bugs
In-Reply-To: <fa.dptrd8v.o4g2i8@ifi.uio.no> <fa.i1142kv.1r0cr0q@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Dec 2001 12:11:28.0906 (UTC) FILETIME=[744316A0:01C1894F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
 > Absolutely no way.  Forwarding "all the little other lists" into
 > linux-kernel is not going to make things better.

But creating a linux-bug list with this policy:

- The stable kernel series point to this lists
- Annoncement to new kernel point to the normal list
    (the bug to newer kernel are classified 'development')
- Kernel maintainers post to the bug list the 'annonces'
    the of solved bugs
- All discussion about kernel series 0.01, 2.0 and 2.2
    (bug hunting series) should go in this new list

In this manner we:
- have a bug tracking system (a' la Linux)
- We can grep quikly to see if a new bug to an
    old kernel is aready closed.

The new list, IMHO, doesn't duplicate trafic,
but I think it don't reduce much of linux-kernel traffic.
(But provide a quicker references of the know bugs).

     giacomo

