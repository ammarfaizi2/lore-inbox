Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293142AbSB1DeO>; Wed, 27 Feb 2002 22:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293145AbSB1DdS>; Wed, 27 Feb 2002 22:33:18 -0500
Received: from ccs.covici.com ([209.249.181.196]:907 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S293142AbSB1DcR>;
	Wed, 27 Feb 2002 22:32:17 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.6-pre1 make oldconfig and make menuconfig don't work
From: John Covici <covici@ccs.covici.com>
Date: Wed, 27 Feb 2002 22:31:10 -0500
Message-ID: <m33czm5lkx.fsf@ccs.covici.com>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1.90
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I was tryhing to get 2.5.6-pre1 working and I tried make
oldconfig with a 2.4.14 .config, but I got the following error:

scripts/Configure: drivers/input/gameport/Config.in: No such file or
directory

When I tried make menuconfig with no .config at all, I got a seg fault
in awk  -- how do I get this working?

Thanks.

-- 
         John Covici
         covici@ccs.covici.com
