Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263544AbUEEICY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUEEICY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 04:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUEEICY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 04:02:24 -0400
Received: from holomorphy.com ([207.189.100.168]:47759 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263544AbUEEICW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 04:02:22 -0400
Date: Wed, 5 May 2004 00:52:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, ashok.raj@intel.com, davidm@hpl.hp.com,
       linux-kernel@vger.kernel.org, anil.s.keshavamurthy@intel.com,
       jreiser@BitWagon.com, mike@navi.cx, pageexec@freemail.hu,
       colpatch@us.ibm.com, rusty@rustcorp.com.au, nickpiggin@yahoo.com.au
Subject: Re: various cpu patches [was: (resend) take3: Updated CPU Hotplug patches]
Message-ID: <20040505075245.GK1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Jackson <pj@sgi.com>, akpm@osdl.org, ashok.raj@intel.com,
	davidm@hpl.hp.com, linux-kernel@vger.kernel.org,
	anil.s.keshavamurthy@intel.com, jreiser@BitWagon.com, mike@navi.cx,
	pageexec@freemail.hu, colpatch@us.ibm.com, rusty@rustcorp.com.au,
	nickpiggin@yahoo.com.au
References: <20040504211755.A13286@unix-os.sc.intel.com> <20040504225907.6c2fe459.akpm@osdl.org> <20040505000348.018f88bb.pj@sgi.com> <20040505072431.GG1397@holomorphy.com> <20040505004456.4fd397f0.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040505004456.4fd397f0.pj@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 12:44:56AM -0700, Paul Jackson wrote:
> The interactions were enough that I probably couldn't expect Andrew to
> wade through them to adapt my cleanup.  Rather I pretty much have to
> deliver my cleanup ready to go, with whatever Andrew thinks is his
> current *-mm series.
> I'll be doing well just to get Andrew to look at it, despite what I take
> to be endorsements from Matthew, Rusty and Joe Korty, and conditional
> acceptance from yourself.  Andrew would probably drop it in a heartbeat
> if it collided non-trivially.
> So merge work - yes.  But merge work that mostly I need to do, which
> makes me very sensitive to the order in which things happen.

Yeah, merging is a pain in the butt. I make vague attempts to merge on a
minute-to-minute basis, but that has me, well, basically livelocked. So
it is with Linux in general, I suppose.


-- wli
