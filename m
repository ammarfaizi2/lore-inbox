Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263778AbUGFLnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUGFLnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 07:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUGFLnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 07:43:43 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:57775 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S263778AbUGFLnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 07:43:42 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andi Kleen <ak@muc.de>
Subject: Re: x86-64 documentation
Date: Tue, 6 Jul 2004 13:52:48 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200407042046.20124.rjwysocki@sisk.pl> <200407061206.01734.rjwysocki@sisk.pl> <20040706113148.GA3050@muc.de>
In-Reply-To: <20040706113148.GA3050@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407061352.48108.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 of July 2004 13:31, Andi Kleen wrote:
> On Tue, Jul 06, 2004 at 12:06:01PM +0200, R. J. Wysocki wrote:
> > On Sunday 04 of July 2004 21:46, Andi Kleen wrote:
> > > On Sun, Jul 04, 2004 at 08:46:20PM +0200, R. J. Wysocki wrote:
> > > > I've just read the Documentation/x86_64/mm.txt.  Is it up to date?
> > >
> > > Mostly yes.
> >
> > How about kernel stacks?  Are they still 16k or they are 8k now?
>
> They were always 8k

Hm.  Does this mean that one register is reserved for the task_struct pointer 
etc. (as stated in mm.txt) or is it done in a different way?

rjw

-- 
Rafael J. Wysocki
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
