Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSJBO3P>; Wed, 2 Oct 2002 10:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263138AbSJBO3P>; Wed, 2 Oct 2002 10:29:15 -0400
Received: from poup.poupinou.org ([195.101.94.96]:263 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S263135AbSJBO3N>;
	Wed, 2 Oct 2002 10:29:13 -0400
Date: Wed, 2 Oct 2002 16:34:31 +0200
To: Chris Wedgwood <cw@f00f.org>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia framebuffer in 2.5
Message-ID: <20021002143431.GA27029@poup.poupinou.org>
References: <200210012211.59573.ivg2@cornell.edu> <20021002080530.GA780@tapu.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021002080530.GA780@tapu.f00f.org>
User-Agent: Mutt/1.3.28i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 01:05:30AM -0700, Chris Wedgwood wrote:
> On Tue, Oct 01, 2002 at 10:11:59PM -0400, Ivan Gyurdiev wrote:
> 
> > This stopped working many kernels ago, and I thought perhaps it's
> > being converted to a different API... but it hasn't been fixed
> > yet..is it a bug?
> 
> That are patches floating about to make it work for 2.5.x; however it
> has some 'schedule while holding locks' issues which may not be fixed
> anytime soon.
> 
> Bug nVIDIA :)

This is the rivafb driver.  Not the binary provided by nvidia.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
