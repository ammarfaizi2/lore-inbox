Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbREWXv6>; Wed, 23 May 2001 19:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263324AbREWXvt>; Wed, 23 May 2001 19:51:49 -0400
Received: from web10508.mail.yahoo.com ([216.136.130.158]:20752 "HELO
	web10508.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S263323AbREWXvk>; Wed, 23 May 2001 19:51:40 -0400
Message-ID: <20010523235139.53193.qmail@web10508.mail.yahoo.com>
Date: Wed, 23 May 2001 16:51:39 -0700 (PDT)
From: Andy Tai <lichengtai@yahoo.com>
Reply-To: atai@atai.org
Subject: information on zerocopy
To: linux-kernel@vger.kernel.org
Cc: atai@atai.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I wonder where can I find documentation or
information on how Linux's zerocopy works. 
Specifically on what conditions does data copy get
eliminated?  Also does it speed up all read and write
operations on sockets?  Or it just works for certain
drivers or network interface cards?  

I went through the kernel source code and still see
copy_from_user() calls in the data paths for socket
writes. But I am new to the kernel source.

Thanks for any information.

__________________________________________________
Do You Yahoo!?
Yahoo! Auctions - buy the things you want at great prices
http://auctions.yahoo.com/
