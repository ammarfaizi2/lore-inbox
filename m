Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262813AbSLIFem>; Mon, 9 Dec 2002 00:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbSLIFel>; Mon, 9 Dec 2002 00:34:41 -0500
Received: from web14608.mail.yahoo.com ([216.136.224.88]:50091 "HELO
	web14608.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262813AbSLIFel>; Mon, 9 Dec 2002 00:34:41 -0500
Message-ID: <20021209054222.8792.qmail@web14608.mail.yahoo.com>
Date: Sun, 8 Dec 2002 21:42:22 -0800 (PST)
From: Santhosh Kumar <linuxkern@yahoo.com>
Subject: Kernel compiled for PPro+, requires PGE feature
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I installed RedHat Linux 8.0 (Kernel Version
2.4.18-14) on my Pentium 4, 1.5GHz system with 2GB
RAM. Everything is working fine. After compiling the
source for 2.4.19, the system does not come up with
the 2.4.19 kernel and gave the error "Kernel compiled
for PPro+, requires PGE feature". How can I get rid of
this ? 

Is there any option that I have to specify for this.
>From "make menuconfig", I have chosen the processor
type to be "Pentium III(Coppermine)" and Highmem
support to be "4GB". I don't want to enable "386"
mode. 

Is there any way by which I can find out the
configuration options for the kernel 2.4.18-14 used by
RedHat 8.0 ? 

Thanks
Santhosh


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
