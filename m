Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264842AbTAEOrI>; Sun, 5 Jan 2003 09:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264836AbTAEOrI>; Sun, 5 Jan 2003 09:47:08 -0500
Received: from bitmover.com ([192.132.92.2]:15068 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S264842AbTAEOrG>;
	Sun, 5 Jan 2003 09:47:06 -0500
Date: Sun, 5 Jan 2003 06:55:39 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jochen Friedrich <jochen@scram.de>, Andreas Dilger <adilger@turbolabs.com>,
       sam@ravnborg.org,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/BK-usage/bksend problems?
Message-ID: <20030105145539.GE1889@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jochen Friedrich <jochen@scram.de>,
	Andreas Dilger <adilger@turbolabs.com>, sam@ravnborg.org,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030105015444.GE29511@merlin.emma.line.org> <Pine.LNX.4.44.0301050839340.19683-100000@gfrw1044.bocc.de> <20030105075842.GA1256@mars.ravnborg.org> <20030105120029.GC5686@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030105120029.GC5686@merlin.emma.line.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 05, 2003 at 01:00:29PM +0100, Matthias Andree wrote:
> Sam Ravnborg schrieb am Sonntag, den 05. Januar 2003:
> 
> > I will submit this with bk sendbug now.
> 
> Thank you. It looks as though the bkbugs stuff expected the list of
> interested parties in a different syntax; when I added my findings, it
> complained about the real names in that list, such as "user Jochen not
> found" or something like that. Looks like it's not RFC-822 "To:" header
> syntax but just a set of mail addresses.

Right.  We'll fix the validation code.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
