Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVABXVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVABXVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 18:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVABXVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 18:21:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12217 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261343AbVABXVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 18:21:04 -0500
Date: Sun, 2 Jan 2005 23:21:02 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: William Lee Irwin III <wli@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org
Subject: Re: starting with 2.7
Message-ID: <20050102232102.GN26717@gallifrey>
References: <1697129508.20050102210332@dns.toxicfilms.tv> <20050102203615.GL29332@holomorphy.com> <20050102212427.GG2818@pclin040.win.tue.nl> <20050102214211.GM29332@holomorphy.com> <20050102221534.GG4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102221534.GG4183@stusta.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.5 (i686)
X-Uptime: 23:08:07 up 8 days, 10:43,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For me, as someone who very rarely actually changes any code in
the kernel, I have always found the stable series useful for
two reasons:

  1) It encourages me to test the kernel; if I have a kernel
  that is generally thought to be stable then I will try it on
  my home machine and report problems - this lets the kernel
  get tested on a wide range of hardware and situations; if there
  is no kernel that is liable to be stable changes will get much
  less testing on a smaller range of hardware.

  2) If I have a bug in a vendor kernel everyone just tells
  me to go and speak to the vendor - so at least having a stable
  base to go back to can let me report a bug that isn't due
  to any vendors patches.

  3) In some cases the commercial vendors don't seem to release
  source to some of the kernels except to people who have bought
  the packages, so those vendor kernel fixes aren't 'publically'
  visible.
  
I think (1) is very important - getting large numbers of people
to test OSS is its greatest asset.
  
Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
