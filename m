Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTAQEHo>; Thu, 16 Jan 2003 23:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267334AbTAQEHo>; Thu, 16 Jan 2003 23:07:44 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:53656 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267319AbTAQEHn>;
	Thu, 16 Jan 2003 23:07:43 -0500
Date: Fri, 17 Jan 2003 05:16:28 +0100
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117041628.GB1794@h55p111.delphi.afb.lu.se>
References: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au> <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18ZNvg-0000xl-00*VHeb6F8ydRA* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 10:12:23PM -0600, Kai Germaschewski wrote:
> > ./scripts/kconfig/mconf arch/i386/Kconfig
> > arch/i386/Kconfig:1185: can't open file "drivers/eisa/Kconfig"
> > make: *** [menuconfig] Error 1
> 
> 	bk -r get -q
> 
> or just
> 
> 	bk get drivers/eisa
> 
> in this case. I guess this is becoming a FAQ.

It would be cool if the the Makefile let make knew about these dependencies
so they would be checked out automagically.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
