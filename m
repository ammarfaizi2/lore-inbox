Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSFGIlM>; Fri, 7 Jun 2002 04:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317240AbSFGIlL>; Fri, 7 Jun 2002 04:41:11 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:415 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S317230AbSFGIlL>; Fri, 7 Jun 2002 04:41:11 -0400
Date: Fri, 7 Jun 2002 09:43:53 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
X-X-Sender: mb@jester.mews
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre10-ac2
In-Reply-To: <Pine.LNX.4.44.0206061041440.28577-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.44.0206070941130.21914-100000@jester.mews>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-uvscan-result: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 6 dean gaudet wrote:

>On Thu, 6 Jun 2002, Matt Bernstein wrote:
>
>> Since when was it OK to do a parallel make dep?
>
>wow such a useful response.  can you point me where this is documented?

No--I read it a few times on lkml, admittedly a year or three ago. 
Googling reveals others must've seen it too, eg:
http://www.ecst.csuchico.edu/~dranch/LINUX/TrinityOS/cHTML/TrinityOS-c-14.html

>i've never seen "make -j3" cause *source files* to be deleted.  there's a
>bug here somewhere.

OK so my response was rather tangential! What unlink()s does strace 
show? What is your fs?

