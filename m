Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317373AbSGTGAP>; Sat, 20 Jul 2002 02:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317374AbSGTGAP>; Sat, 20 Jul 2002 02:00:15 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:12718
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id <S317373AbSGTGAO>; Sat, 20 Jul 2002 02:00:14 -0400
Message-ID: <3D38FCD7.D2118D2E@rogers.com>
Date: Sat, 20 Jul 2002 02:01:59 -0400
From: John Kacur <jkacur@rogers.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net> <20020718213857.E23208@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.101.229.155] using ID <jkacur@rogers.com> at Sat, 20 Jul 2002 02:03:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> 
> On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote:
> > I've been sitting on this question for years, hoping I'd come across the
> > answer, and I STILL don't know what the "i" is short for.  Somebody here has
> > got to know this. :)
> 
> Incore node, I believe.  In the original Unix code there was dinode and
> inode if I remember correctly, for disk node and incore node.

According to Uresh Vahalia in "Unix Internals, The New Frontiers", 
"The word inode derives from index node. ... Whenever it is ambiguous,
we use the term on-disk inode to refer to the on-disk data structure
(struct dinode) and in-core inode to refer to the in-memory structure
(struct inode)
