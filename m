Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbREYXcC>; Fri, 25 May 2001 19:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262050AbREYXbv>; Fri, 25 May 2001 19:31:51 -0400
Received: from smtp6vepub.gte.net ([206.46.170.27]:17435 "EHLO
	smtp6ve.mailsrvcs.net") by vger.kernel.org with ESMTP
	id <S262027AbREYXbj>; Fri, 25 May 2001 19:31:39 -0400
From: George France <france@handhelds.org>
Date: Fri, 25 May 2001 19:31:21 -0400
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
To: Jay Thorne <Yohimbe@userfriendly.org>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org> <01052518523300.28075@shadowfax.middleearth> <990831934.27357.4.camel@gracie.userfriendly.org>
In-Reply-To: <990831934.27357.4.camel@gracie.userfriendly.org>
Subject: Re: PROBLEM: Alpha SMP Low Outbound Bandwidth
MIME-Version: 1.0
Message-Id: <01052519312101.28075@shadowfax.middleearth>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 May 2001 19:05, Jay Thorne wrote:
> On 25 May 2001 18:52:33 -0400, George France wrote:
> > Hello Jay,
> >
> > I see that you are using the tulip driver.  Could you try the de4x5
> > driver??
>
> Its worse: reports 3.1 MBs and 1.6 MBs

wuftp is not exactly a performance benchmark, have you tried 'netperf'?

--George
