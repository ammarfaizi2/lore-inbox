Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSINVo7>; Sat, 14 Sep 2002 17:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317571AbSINVo7>; Sat, 14 Sep 2002 17:44:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:64265 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317544AbSINVo6>; Sat, 14 Sep 2002 17:44:58 -0400
Date: Sat, 14 Sep 2002 22:49:46 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [BK PATCH] console updates.
Message-ID: <20020914224946.C18537@flint.arm.linux.org.uk>
References: <Pine.LNX.4.33.0209121610470.10152-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0209121610470.10152-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Thu, Sep 12, 2002 at 04:13:38PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 04:13:38PM -0700, James Simmons wrote:
>    Here is the latest console code that has been sitting around in Dave
> Jone's tree for some time. This patch removes the many global variables
> the console system uses. Since Vojtech input keyboards went this diff has
> shrunk. If you could apply it I would be happy.
> 
> bk://linuxconsole.bkbits.net/dev

gnu patch?  diffstat output?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

