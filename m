Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132025AbRCVOA3>; Thu, 22 Mar 2001 09:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132026AbRCVOAK>; Thu, 22 Mar 2001 09:00:10 -0500
Received: from viper.haque.net ([64.0.249.226]:33925 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S132025AbRCVN7w>;
	Thu, 22 Mar 2001 08:59:52 -0500
Message-ID: <3ABA0402.1E1E5959@haque.net>
Date: Thu, 22 Mar 2001 08:54:10 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolinux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext2_unlink fun
In-Reply-To: <200103212128.f2LLSRx20724@webber.adilger.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> > Correct, this was after running e2fsck. I'll try running it again when I
> > get home. Here is debugfs stat output for one of the broken files.
> > Again, I havent run e2fsck a second time yet.

Ok, I ran e2fsck twice last night. It didnt do anything the first run
but then second time around it found those files and fixed the problem.
Weird.

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
