Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289281AbSANXPZ>; Mon, 14 Jan 2002 18:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289277AbSANXPS>; Mon, 14 Jan 2002 18:15:18 -0500
Received: from offended.co.uk ([217.204.248.2]:7825 "EHLO fw.tomsflat")
	by vger.kernel.org with ESMTP id <S289283AbSANXOy>;
	Mon, 14 Jan 2002 18:14:54 -0500
Date: Mon, 14 Jan 2002 23:14:51 +0000
From: Tom Gilbert <tom@linuxbrit.co.uk>
To: linux-kernel@vger.kernel.org
Cc: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Penelope builds a kernel
Message-ID: <20020114231451.J9555@ummagumma>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	"Eric S. Raymond" <esr@thyrsus.com>
In-Reply-To: <20020114165909.A20808@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114165909.A20808@thyrsus.com>
User-Agent: Mutt/1.3.23i
X-Editor: Vim http://www.vim.org/
X-Info: http://www.linuxbrit.co.uk
Organisation: Poor
X-Operating-System: Linux/2.4.10-ac9 (i686)
X-Uptime: 23:11:08 up 34 days,  4:42,  5 users,  load average: 0.26, 0.12, 0.04
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric S. Raymond (esr@thyrsus.com) wrote:
> Scenario #3: Penelope goes where the geeks are surfing.
> If Penelope learns from the README file that all *she* has to do is
> type "configure; make" to build a kernel that supports her hardware,
> she can apply that MEMS card patch and build with confidence that the
> effort is unlikely to turn into an infinite time sink.
> 
> Autoconfigure saves the day again.  That guy in the penguin T-shirt
> might even be impressed...

$ apt-cache search kernel-patch | wc -l
     66

And I guarantee that if Penelope calls up her vendor, she can get
someone to provide her a guaranteed-compatible and *tested* driver that
can be managed by her package manager for less than the price of the
pack of twelve she'll be using with the dude in the penguin t-shirt.

Please try to understand the entire _point_ of distributions and get a
grasp of how vendors work with the kernel, and stop waxing lyrical about
contrived situations.

Tom.
-- 
   .^.    .-------------------------------------------------------.
   /V\    | Tom Gilbert, London, England | http://linuxbrit.co.uk |
 /(   )\  | Open Source/UNIX consultant  | tom@linuxbrit.co.uk    |
  ^^-^^   `-------------------------------------------------------'
