Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbTAQEQs>; Thu, 16 Jan 2003 23:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267365AbTAQEQs>; Thu, 16 Jan 2003 23:16:48 -0500
Received: from bitmover.com ([192.132.92.2]:45792 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S267359AbTAQEQr>;
	Thu, 16 Jan 2003 23:16:47 -0500
Date: Thu, 16 Jan 2003 20:25:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: Anders Gustafsson <andersg@0x63.nu>
Cc: Larry McVoy <lm@bitmover.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Carl Gherardi <C.Gherardi@curtin.edu.au>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.59
Message-ID: <20030117042541.GC15753@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Anders Gustafsson <andersg@0x63.nu>, Larry McVoy <lm@bitmover.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Carl Gherardi <C.Gherardi@curtin.edu.au>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8B67F2E2D93ED5118D6E00508BB8D127011C3ED0@exmsb04.curtin.edu.au> <Pine.LNX.4.44.0301162211410.19302-100000@chaos.physics.uiowa.edu> <20030117041739.GA15753@work.bitmover.com> <20030117042041.GC1794@h55p111.delphi.afb.lu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030117042041.GC1794@h55p111.delphi.afb.lu.se>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Whats the difference between bk co and bk get?

co has RCS compat options and get has SCCS compat options.  If you are 
used to CVS/RCS, "bk co" and "bk ci" are your friend, if you are used
to SCCS then "bk get" and "bk delta" are what you like.   They do the
same thing.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
