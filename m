Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316035AbSETOJQ>; Mon, 20 May 2002 10:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316042AbSETOJP>; Mon, 20 May 2002 10:09:15 -0400
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:58012 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP
	id <S316035AbSETOJN>; Mon, 20 May 2002 10:09:13 -0400
Date: Mon, 20 May 2002 16:09:09 +0200
From: Marc Lehmann <schmorp@schmorp.de>
To: John Ruttenberg <rutt@chezrutt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dell Inspiron i8100 with 2 batteries
Message-ID: <20020520140909.GA29491@schmorp.de>
Mail-Followup-To: John Ruttenberg <rutt@chezrutt.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15589.4802.37068.931146@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux version 2.4.18-pre8-ac3 (root@cerebro) (gcc version 2.95.4 20010319 (prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 10:25:06AM -0400, John Ruttenberg <rutt@chezrutt.com> wrote:
> I am using 2.4.18 and have a Dell I8100 with 2 batteries.  If combined charge

I also have this notebook, and the APM bios is rather broken. You might try
downgrading your BIOS to A07 or so, that *could* help (it helped here).

ACPI doesn't work stably on that machine (not here, at least), and doesn't
seem to be desirable, as reading battery status freezes the machine for
0.2s ;)

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
