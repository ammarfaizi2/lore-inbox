Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267336AbTAQEMA>; Thu, 16 Jan 2003 23:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267348AbTAQEMA>; Thu, 16 Jan 2003 23:12:00 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:57496 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267336AbTAQEL6>;
	Thu, 16 Jan 2003 23:11:58 -0500
Date: Fri, 17 Jan 2003 05:20:41 +0100
To: Larry McVoy <lm@work.bitmover.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Carl Gherardi <C.Gherardi@curtin.edu.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117042041.GC1794@h55p111.delphi.afb.lu.se>
References: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au> <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu> <20030117041739.GA15753@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117041739.GA15753@work.bitmover.com>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18ZNzl-0000zy-00*iW1TokbAVyM* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 08:17:39PM -0800, Larry McVoy wrote:
> A little know option which makes things go faster is 
> 
> 	bk -r get -qS
> 
> which gets only those files not already gotten.  Linus has asked why this 
> isn't the default and the only reason I can give him is that it is an
> interface change and we'll do it in bk 4.0.  It's the right answer.

Whats the difference between bk co and bk get?

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
