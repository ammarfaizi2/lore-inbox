Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317585AbSFIJql>; Sun, 9 Jun 2002 05:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSFIJqk>; Sun, 9 Jun 2002 05:46:40 -0400
Received: from ns.suse.de ([213.95.15.193]:27147 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317585AbSFIJqi>;
	Sun, 9 Jun 2002 05:46:38 -0400
Date: Sun, 9 Jun 2002 11:46:38 +0200
From: Dave Jones <davej@suse.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, linux-kernel@vger.kernel.org,
        chaffee@cs.berkeley.edu
Subject: Re: [patch] fat/msdos/vfat crud removal
Message-ID: <20020609114638.J13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	linux-kernel@vger.kernel.org, chaffee@cs.berkeley.edu
In-Reply-To: <87r8jhc685.fsf@devron.myhome.or.jp> <200206090709.g5979iK439624@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 03:09:44AM -0400, Albert D. Cahalan wrote:

 > There has been talk of removing __KERNEL__ usage from
 > some of the header files.

Where? If anything we need to increase __KERNEL__ usage in headers.
We export far too much crap which makes no sense to userspace.

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
