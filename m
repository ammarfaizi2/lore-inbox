Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290551AbSBKWkK>; Mon, 11 Feb 2002 17:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290578AbSBKWj7>; Mon, 11 Feb 2002 17:39:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54278 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290551AbSBKWjm>;
	Mon, 11 Feb 2002 17:39:42 -0500
Message-ID: <3C6847F9.62FC586A@zip.com.au>
Date: Mon, 11 Feb 2002 14:38:49 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: axel@kioskdu.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Unbknown / uncomprehensible bug reported
In-Reply-To: <3C6842E3.181C9D7C@kioskdu.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axel wrote:
> 
> Linux version 2.4.4-4GB (root@Pentium.suse.de) (gcc version 2.95.3
> ...
> Feb 11 11:08:26 darkstar pppoe[547]: Linux select bug hit!  This message
> is harmless, but please ask the Linux kernel developers to fix it.

An update went into drivers/char/n_hdlc.c in kernel 2.4.18-pre1
which should have fixed this.

-
