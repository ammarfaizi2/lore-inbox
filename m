Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293082AbSBWCGJ>; Fri, 22 Feb 2002 21:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293083AbSBWCF6>; Fri, 22 Feb 2002 21:05:58 -0500
Received: from harddata.com ([216.123.194.198]:32528 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S293082AbSBWCFm>;
	Fri, 22 Feb 2002 21:05:42 -0500
Date: Fri, 22 Feb 2002 19:05:38 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 2.4.18-rc4 does not boot
Message-ID: <20020222190538.A3819@mail.harddata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, Feb 18, I posted a message that 2.4.18-pre9-ac4
fails to boot on my machine with

FAT: bogus logical sector size 0
FAT: bogus logical sector size 0
Kernel panic: VFS: Unable to mount root fs on 03:00

messages.  2.4.18-rc1, and many different kernels, do not have
troubles of that sort.  Tonight I found to my dismay that the
same trouble afflicted 2.4.18-rc4.  No, I do not know why this
happens; at least at this moment.

   Michal
