Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261927AbVCCQUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261927AbVCCQUb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:20:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVCCQUb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:20:31 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11435 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261927AbVCCQUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:20:21 -0500
Subject: Re: RFD: Kernel release numbering
From: Lee Revell <rlrevell@joe-job.com>
To: Prakash Punnoor <prakashp@arcor.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4226E6F3.2030803@arcor.de>
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>
	 <20050303002047.GA10434@kroah.com>
	 <Pine.LNX.4.58.0503021710430.25732@ppc970.osdl.org>
	 <200503022121.07679.gene.heskett@verizon.net>  <4226E6F3.2030803@arcor.de>
Content-Type: text/plain
Date: Thu, 03 Mar 2005 11:20:18 -0500
Message-Id: <1109866818.2908.3.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-03 at 11:29 +0100, Prakash Punnoor wrote:
> A gentoo view: There are lots of patchsets floating around in the gentoo forum
> based on either vanilla or mm-kernel, but over the months something has
> changed: Previously most patchsets were based on mm, but now are based on
> vanilla. Why? Very simple: mm became too unstable. I used to go with a mm
> based kernel just for fun, but it changed as one kernel had some serious
> issues with reiserfs - and it is really not fun to lose data. (At least I read
> about it, before testing that kernel.) Since then i never touched a mm-kernel
> again, in fact now I even feel scared to put on a vanilla-rc kernel. I do it,
> but I feel like when I use a "stable" mm-kernel from earlier times...
> 
> So if you wantpeople to test kernels, they shouldn't be too unstable...

Thanks, it's about time someone said this.

We had a preview of what it would be like if "more users tested -mm"
when Ingo's realtime preempt patches were based on it, so the audio
oriented distros briefly shipped -mm kernels.

It was a nightmare.  Most people (icluding myself) experienced daily
lockups.  When Ingo rebased the RT patch against mainline there was
muich rejoicing on LAU.

-mm is just too unstable for anyone but kernel hackers to run.  Anyone
who tells you otherwise is smoking something.

Lee



