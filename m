Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJBFYT>; Tue, 2 Oct 2001 01:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275822AbRJBFYK>; Tue, 2 Oct 2001 01:24:10 -0400
Received: from granger.mail.mindspring.net ([207.69.200.148]:28935 "EHLO
	granger.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S275816AbRJBFYC>; Tue, 2 Oct 2001 01:24:02 -0400
Subject: Re: ext3 0.9.10 for Alan's tree
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@zip.com.au>
Cc: sct@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3BB946B4.C7479C16@zip.com.au>
In-Reply-To: <1001989916.2780.61.camel@phantasy> 
	<3BB946B4.C7479C16@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 02 Oct 2001 01:24:31 -0400
Message-Id: <1002000273.865.13.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-02 at 00:46, Andrew Morton wrote:
> Yes, sorry.  It's turning out to be a lot of work keeping the master
> ext3 tree in sync with two (rather different) kernels, and running around
> after all the changes which are happening in (ahem) one of them.

Don't explain that -- I know :) I think all of us are wanting a
single-tree development kernel about now...

> We prefer to test a lot before releasing, and the one time I skipped
> that step was for 2.4.10, and it was the one which is broken. Sigh.
> 
> Rob, I've added this patch to the download site for interested parties
> to use.  http://www.uow.edu.au/~andrewm/linux/ext3/

Great.

> But for a merge with Alan we do have a few more changes backed up,
> and some more testing must be done.  I'll try to prepare 0.9.11
> for -ac this week.  I'm inclined to down-tools on Linus kernels
> for a while, wait for things to settle down there.

I'll be happy to test and do anything else I can.  Thanks for the reply
and all.

> Thanks!

You are welcome :)

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

