Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263630AbUJ2ViF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263630AbUJ2ViF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263524AbUJ2Vct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:32:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38153 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263615AbUJ2VbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:31:15 -0400
Date: Fri, 29 Oct 2004 23:30:43 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Hacksaw <hacksaw@hacksaw.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041029213043.GU6677@stusta.de>
References: <m1sm7znxul.fsf@mo.optusnet.com.au> <200410280728.i9S7SIYW017628@hacksaw.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410280728.i9S7SIYW017628@hacksaw.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 03:28:18AM -0400, Hacksaw wrote:

> > That's NOT the same as bug free software. For a start, there's no such
> > thing.
> 
> Speaking of which, here's something I have wondered: is anyone out there 
> trying to prove the correctness of core functions in the kernel? I was 
> thinking this would be a fine activity for all those eager college students 
> out there, or perhaps a graduate student project, a la the Stanford Checker 
> project.
> 
> While I can't imagine the main developers doing such a thing, I think it'd be 
> useful and might uncover some hard to find bugs.
> 
> I'd also suspect that they might be good candidates for proving, as there's 
> not so much reason to have side effect riddled code, as one might for GUI 
> programs.

Did you ever try to prove the correctness of some piece of code in an 
imperative programming language? That's definitely not only "a graduate 
student project".

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

