Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315805AbSFPCWB>; Sat, 15 Jun 2002 22:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315806AbSFPCWA>; Sat, 15 Jun 2002 22:22:00 -0400
Received: from ccs.covici.com ([209.249.181.196]:26773 "EHLO ccs.covici.com")
	by vger.kernel.org with ESMTP id <S315805AbSFPCWA>;
	Sat, 15 Jun 2002 22:22:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15627.63040.620383.846497@ccs.covici.com>
Date: Sat, 15 Jun 2002 22:21:52 -0400
From: John covici <covici@ccs.covici.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 make problem
In-Reply-To: <20020616010006.A19935@mars.ravnborg.org>
X-Mailer: VM 7.05 under Emacs 21.3.50.1
Reply-To: covici@ccs.covici.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did the mrproper then the make with the clean and then the make
without the clean in that order and still no results.


on Sunday 06/16/2002 Sam Ravnborg(sam@ravnborg.org) wrote
 > On Sat, Jun 15, 2002 at 06:38:57PM -0400, John covici wrote:
 > > I had the bright idea of taking the clean out of there, so I was left
 > > with
 > > make dep bzImage modules_install 2>&1 |tee foo
 > > 
 > > but that didn't help -- thought it would.
 > 
 > I have once seen something similar.
 > Have you tried "make mrproper" to clean up and try again?
 > 
 > 	Sam

-- 
         John Covici
         covici@ccs.covici.com
