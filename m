Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTAaW53>; Fri, 31 Jan 2003 17:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTAaW53>; Fri, 31 Jan 2003 17:57:29 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:24975 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S263039AbTAaW53>;
	Fri, 31 Jan 2003 17:57:29 -0500
Date: Sat, 1 Feb 2003 00:06:38 +0100
To: Chris Wedgwood <cw@f00f.org>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [Bitkeeper-announce] Re: bkbits.net downtime
Message-ID: <20030131230638.GA17360@h55p111.delphi.afb.lu.se>
References: <200301312114.h0VLEmC11997@work.bitmover.com> <20030131145018.N3904@schatzie.adilger.int> <20030131224627.GA1686@f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030131224627.GA1686@f00f.org>
User-Agent: Mutt/1.5.3i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18ekF4-0005lg-00*Dmw8AzP58Uw* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 02:46:27PM -0800, Chris Wedgwood wrote:

> ... assuming BK read-only copies do work, why not actually have 'bk
> pull' for hosts which can serve RO copies of the trees?  You
> could use SRV records to locate these transparently to what has been
> deployed now (I'm not really a fan of rfc2782.txt but nonetheless it
> exists and others are using it, so it's a 'standard' of sorts).

Or simply a domain-name with multiple A's with should work today
out-of-the-box.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
