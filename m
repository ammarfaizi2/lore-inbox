Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286723AbSAUO04>; Mon, 21 Jan 2002 09:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSAUO0q>; Mon, 21 Jan 2002 09:26:46 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:57092 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S286723AbSAUO0j>; Mon, 21 Jan 2002 09:26:39 -0500
Date: Mon, 21 Jan 2002 14:29:05 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020121142903.GA73605@compsoc.man.ac.uk>
In-Reply-To: <3C4B6F24.C2750F51@zip.com.au> <200201210934.g0L9Y7qV001830@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201210934.g0L9Y7qV001830@tigger.cs.uni-dortmund.de>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
X-Scanner: exiscan *16SfOx-000OxC-00*HCwu9uYDQnk* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 10:34:07AM +0100, Horst von Brand wrote:

> > 2: Breaks the kernel profiler
> 
> Which one?

readprofile(3) - the histogram only extends across the .text of the monolithic
kernel image

regards
john

-- 
"I hope you will find the courage to keep on living 
 despite the existence of this feature."
	- Richard Stallman
