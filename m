Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310479AbSCLVMO>; Tue, 12 Mar 2002 16:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311335AbSCLVME>; Tue, 12 Mar 2002 16:12:04 -0500
Received: from xenial.mcc.ac.uk ([130.88.203.16]:32518 "EHLO xenial.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S311345AbSCLVLz>;
	Tue, 12 Mar 2002 16:11:55 -0500
Date: Tue, 12 Mar 2002 21:11:50 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Kernel profiling
Message-ID: <20020312211150.GA57908@compsoc.man.ac.uk>
In-Reply-To: <3C8E5712.20E5E317@scali.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8E5712.20E5E317@scali.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 08:29:22PM +0100, Steffen Persvold wrote:

> Is it possible to use the kernel profiling functionality to do
> profiling on loadable modules ?

I imagine it wouldn't be too hard to extend the profiling buffer for
the module text regions ...

> If no, is there any other easy method ?

http://oprofile.sf.net

regards
john

-- 
I am a complete moron for forgetting about endianness. May I be
forever marked as such.
