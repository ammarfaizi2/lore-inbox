Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271737AbTHHSCd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 14:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271738AbTHHSCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 14:02:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:40679 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S271737AbTHHSCc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 14:02:32 -0400
Date: Fri, 8 Aug 2003 20:02:24 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Ian Hoffman <no99goal@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 won't compile
Message-ID: <20030808180224.GB16091@fs.tum.de>
References: <20030808164337.35815.qmail@web13305.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030808164337.35815.qmail@web13305.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 09:43:37AM -0700, Ian Hoffman wrote:
>...
>   AS      usr/initramfs_data.o
> /tmp/ccdNnIMg.s: Assembler messages:
> /tmp/ccdNnIMg.s:7: Error: Unknown pseudo-op: 
> `.incbin'
> make[1]: *** [usr/initramfs_data.o] Error 1
> make: *** [usr] Error 2
>...
> binutils               2.11.90.0.8
>...

You need binutils >= 2.12 (this is also stated in 
Documentation/Changes).

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

