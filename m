Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268346AbTCCGjN>; Mon, 3 Mar 2003 01:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268347AbTCCGjN>; Mon, 3 Mar 2003 01:39:13 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57474 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268346AbTCCGjM>; Mon, 3 Mar 2003 01:39:12 -0500
Date: Mon, 3 Mar 2003 12:24:53 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend Functionality in 2.5
Message-ID: <20030303122453.A2634@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1046369790.2190.9.camel@laptop-linux.cunninghams> <20030228121725.B2241@in.ibm.com> <20030228130548.GA8498@atrey.karlin.mff.cuni.cz> <20030228190924.A3034@in.ibm.com> <20030228134406.GA14927@atrey.karlin.mff.cuni.cz> <20030228204831.A3223@in.ibm.com> <20030228151744.GB14927@atrey.karlin.mff.cuni.cz> <1046458775.1720.5.camel@laptop-linux.cunninghams> <20030303095824.A2312@in.ibm.com> <1046673408.27945.5.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1046673408.27945.5.camel@laptop-linux.cunninghams>; from ncunningham@clear.net.nz on Mon, Mar 03, 2003 at 07:36:49PM +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 03, 2003 at 07:36:49PM +1300, Nigel Cunningham wrote:
> Hi.
> 
> On Mon, 2003-03-03 at 17:28, Suparna Bhattacharya wrote:
> > If you add to that the possibility of being able to save more 
> > in less space if you have compression, would it be useful ?
> 
> I'm not sure that it would because we don't know how much compression
> we're going to get ahead of time, so we don't know how many extra pages

The algorithm could be adjusted to deal with that, however ...

> we can save. The compression/decompression also takes extra time and
> puts more drain on a potentially low battery.

.. I didn't think about the battery drain - valid point !

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

