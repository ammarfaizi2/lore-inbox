Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261821AbTCQSBv>; Mon, 17 Mar 2003 13:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbTCQSBv>; Mon, 17 Mar 2003 13:01:51 -0500
Received: from msp-24-163-212-250.mn.rr.com ([24.163.212.250]:44960 "EHLO
	msp-24-163-212-250.mn.rr.com") by vger.kernel.org with ESMTP
	id <S261821AbTCQSBu>; Mon, 17 Mar 2003 13:01:50 -0500
Subject: Re: BK->CVS is live
From: Shawn <core@enodev.com>
To: Larry McVoy <lm@bitmover.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200303171552.h2HFqK907234@work.bitmover.com>
References: <200303171552.h2HFqK907234@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1047924757.11766.18.camel@msp-24-163-212-250.mn.rr.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.1.99 (Preview Release)
Date: 17 Mar 2003 12:12:38 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah!

Oh, and while I was sending this, I thought I'd ask a question.
Regarding the folks who still say "not good enough", might it be
possible to export bk metadata into, say, a compressed file in each
subdir in the repository? Such a file would contain any relevant bk
metadata for files in that subdir.

I don't know if that's something one would want to do for performance
reasons or otherwise, but it sound like the thing that would finally
quiet those who are complaining.

Good work! I hope BitchKeeper turns out just as nice.

On Mon, 2003-03-17 at 09:52, Larry McVoy wrote:
> I think those repositories are stable enough you can start to count on
> them.  Sam and others have looked over their changes and think that 
> the CVS tree has accurate data.
> 
> The CVS repository is at
> 
>     cvs -d:pserver:anonymous@kernel.bkbits.net:/home/cvs
> 
> and it has two top level directories, linux-2.4 and linux-2.5.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
