Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278209AbRJMA0y>; Fri, 12 Oct 2001 20:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278215AbRJMA0p>; Fri, 12 Oct 2001 20:26:45 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26101
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S278209AbRJMA0g>; Fri, 12 Oct 2001 20:26:36 -0400
Date: Fri, 12 Oct 2001 17:27:02 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Updated preempt-kernel patches
Message-ID: <20011012172702.A16500@mikef-linux.matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1002917978.957.86.camel@phantasy> <1002925193.868.5.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1002925193.868.5.camel@phantasy>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 06:19:52PM -0400, Robert Love wrote:
> On Fri, 2001-10-12 at 16:19, Robert Love wrote:
> > - fix compile on SMP in some configurations (ac tree only)
> 
> Looks like I forgot to merge that one.  Fix follows below (its needed by
> some ac-tree users who also compile SMP).
>

Again? ;)

Any idea how it would work on any smp systems using the -ac tree?

