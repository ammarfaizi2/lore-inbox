Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289167AbSANXFf>; Mon, 14 Jan 2002 18:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289156AbSANXFX>; Mon, 14 Jan 2002 18:05:23 -0500
Received: from offended.co.uk ([217.204.248.2]:145 "EHLO fw.tomsflat")
	by vger.kernel.org with ESMTP id <S289160AbSANXCn>;
	Mon, 14 Jan 2002 18:02:43 -0500
Date: Mon, 14 Jan 2002 23:02:39 +0000
From: Tom Gilbert <tom@linuxbrit.co.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020114230239.I9555@ummagumma>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020114111141.A14332@thyrsus.com> <Pine.LNX.4.43.0201141231330.31316-100000@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0201141231330.31316-100000@waste.org>
User-Agent: Mutt/1.3.23i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.linuxbrit.co.uk
Organisation: Poor
X-Operating-System: Linux/2.4.10-ac9 (i686)
X-Uptime: 23:02:05 up 34 days,  4:33,  5 users,  load average: 0.02, 0.05, 0.01
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Oliver Xymoron (oxymoron@waste.org) wrote:
> On Mon, 14 Jan 2002, Eric S. Raymond wrote:
> 
> > Michael Lazarou (ETL) <Michael.Lazarou@etl.ericsson.se>:
> > > Doesn't this mean that you would need a fully functional kernel
> > > before you get to run the autoconfigurator?
> >
> > Yes, but this was always true.
> 
> No it's not. You only need a kernel that can run your compiler.

It's already been pointed out that the autconfigurator requires a great
many in-kernel features and userspace utilities.

Tom.
-- 
   .^.    .-------------------------------------------------------.
   /V\    | Tom Gilbert, London, England | http://linuxbrit.co.uk |
 /(   )\  | Open Source/UNIX consultant  | tom@linuxbrit.co.uk    |
  ^^-^^   `-------------------------------------------------------'
