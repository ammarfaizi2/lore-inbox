Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSIWVsZ>; Mon, 23 Sep 2002 17:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261493AbSIWVsY>; Mon, 23 Sep 2002 17:48:24 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:10935 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261492AbSIWVsW>;
	Mon, 23 Sep 2002 17:48:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Mon, 23 Sep 2002 23:53:47 +0200
X-Mailer: KMail [version 1.3.2]
Cc: axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <20020923120400.A15452@acpi.pdx.osdl.net> <E17tZyv-0003be-00@starship> <20020923144144.A15852@acpi.pdx.osdl.net>
In-Reply-To: <20020923144144.A15852@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tb9H-0003d7-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 September 2002 23:41, Dave Olien wrote:
> On Mon, Sep 23, 2002 at 10:39:00PM +0200, Daniel Phillips wrote:
> > Minor whitespace suggestion: don't worry too much about breaking up
> > lines to fit in 80 columns.  It's nice where it works, but where it
> > just makes more lines, don't bother.  We are going to go do spelling
> > patches to shorten a lot of those names anyway.
> 
> thanks.
> I'd been wondering whether there was a guidline for this.
> I'll relax my 80 column constraints.

It's a lot more important for core kernel, and ever there, a few lines
tend to break loose here and there.
 
Thanks for the test code.  Using your recipe, I confirmed I have the
same controller as you.  Running on a dual PIII in my case.

Apparently Jens has a DAC as well.  Jens, is it the same?

-- 
Daniel
