Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264375AbRG0XKm>; Fri, 27 Jul 2001 19:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264461AbRG0XKc>; Fri, 27 Jul 2001 19:10:32 -0400
Received: from suntan.tandem.com ([192.216.221.8]:51592 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S264375AbRG0XKW>; Fri, 27 Jul 2001 19:10:22 -0400
Message-ID: <3B61F0F0.8E211AB5@compaq.com>
Date: Fri, 27 Jul 2001 15:53:36 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.7 read/write semaphore trylock routines
In-Reply-To: <200107272233.f6RMXOt02880@sandbass.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"Brian J. Watson" wrote:
> 
> Linus-
> 
> This patch adds non-blocking routines for grabbing read/write
> semaphores. David Howells has seen it already, and has no problem with
> it. I've hammered on both the i386 and generic versions with a
> contention test, and the code works correctly.
> 
> I think it's ready to be included.
> 

Sorry. I'm just getting used to mail, since Netscape mangles patches. This is my real reply address. bwatson@sandbass.cpqcorp.net is invalid.


-- 
Brian Watson                | "The common people of England... so 
Linux Kernel Developer      |  jealous of their liberty, but like the 
Open SSI Clustering Project |  common people of most other countries 
Compaq Computer Corp        |  never rightly considering wherein it 
Los Angeles, CA             |  consists..."
                            |     -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
