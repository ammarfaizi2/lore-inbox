Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTL1Pjo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 10:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTL1Pjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 10:39:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261605AbTL1Pjn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 10:39:43 -0500
Date: Sun, 28 Dec 2003 15:39:41 +0000
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org
Subject: Re: CD burn buffer underruns on 2.6
Message-ID: <20031228153941.GA851@gallifrey>
References: <16366.60194.935861.592797@nycap.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16366.60194.935861.592797@nycap.rr.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0 (i686)
X-Uptime: 15:37:16 up 7 min,  1 user,  load average: 0.07, 0.26, 0.15
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* craig duncan (duncan@nycap.rr.com) wrote:
> 
> Dec 24 08:24:44 cdw kernel: cdrom_newpc_intr: 110 residual after xfer

Hmm - I'm seeing those just playing an audio CD on 2.6.0:

cdrom_newpc_intr: 3 residual after xfer

(That is a Memorex 24MAXX 1040 CD R/W on an AMD766 controller on a dual
Athlon MP board).

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
