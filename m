Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278771AbRJZRpa>; Fri, 26 Oct 2001 13:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278797AbRJZRpU>; Fri, 26 Oct 2001 13:45:20 -0400
Received: from domino1.resilience.com ([209.245.157.33]:46076 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S278771AbRJZRpO>; Fri, 26 Oct 2001 13:45:14 -0400
Message-ID: <3BD9AF2B.FC9D4977@resilience.com>
Date: Fri, 26 Oct 2001 11:44:59 -0700
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.12-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Deadlock with linux kernel
In-Reply-To: <E15xB2K-0000oI-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Also, I don't see any signs of a kernel Oops in the syslog, so that
> > doesn't appear to be the problem.
> 
> Does the capslock key stil work when it locks up. I suspect you are seeing
> a non VM related problem. The VM stuff has tended to be livelocks rather
> than hung boxes.

Hmm, I haven't noticed.  I'll be sure to check that next time it occurs.

-Jeff

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
