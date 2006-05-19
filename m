Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964810AbWESUPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbWESUPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWESUPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:15:14 -0400
Received: from nevyn.them.org ([66.93.172.17]:49636 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S964810AbWESUPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:15:13 -0400
Date: Fri, 19 May 2006 16:15:09 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2-ptrace_multi
Message-ID: <20060519201509.GA13477@nevyn.them.org>
Mail-Followup-To: Renzo Davoli <renzo@cs.unibo.it>,
	Ulrich Drepper <drepper@gmail.com>, Andi Kleen <ak@suse.de>,
	osd@cs.unibo.it, linux-kernel@vger.kernel.org
References: <20060518155337.GA17498@cs.unibo.it> <20060518155848.GC17498@cs.unibo.it> <p73sln72im3.fsf@bragg.suse.de> <20060518211321.GC6806@cs.unibo.it> <a36005b50605181923k285b4d50y30d6b43baede95ca@mail.gmail.com> <20060519090726.GA11789@cs.unibo.it> <20060519130952.GA1242@nevyn.them.org> <20060519174534.GA22346@cs.unibo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519174534.GA22346@cs.unibo.it>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 07:45:34PM +0200, Renzo Davoli wrote:
> #ifndef mem_write
> /* This is a security hazard */

I believe the conclusion, when this was last discussed, was that this
is not true and could be fixed.

-- 
Daniel Jacobowitz
CodeSourcery
