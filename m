Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272093AbRIELni>; Wed, 5 Sep 2001 07:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272099AbRIELn1>; Wed, 5 Sep 2001 07:43:27 -0400
Received: from mailgate.indstate.edu ([139.102.15.118]:31397 "EHLO
	mailgate.indstate.edu") by vger.kernel.org with ESMTP
	id <S272093AbRIELnH>; Wed, 5 Sep 2001 07:43:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rich Baum <richbaum@acm.org>
To: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: no files shown on UDF DVD
Date: Tue, 4 Sep 2001 20:57:56 -0500
X-Mailer: KMail [version 1.2.9]
Cc: linux_udf@hpesjro.fc.hp.com, bfennema@falcon.csc.calpoly.edu
In-Reply-To: <20010903194809.A15650@hapablap.dyn.dhs.org>
In-Reply-To: <20010903194809.A15650@hapablap.dyn.dhs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <A97C213D54@coral.indstate.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 September 2001 07:48 pm, Steven Walter wrote:
> When I mount the Matrix DVD using the iso9660 filesystem, it appears
> that the filesystem hierarchy is correct.
>
> If, however, I use the udf filesystem, there are exactly zero files
> shown as being on the CD.  As I understand it, this should not be the
> case.
>
> I've attached the UDF-fs DEBUG messages that resulted from
> mounting the DVD.  I hope they're helpful in resolving this.

I saw this message and decided to try out mounting all of my DVDs as udf. 
under 2.4.10pre4.  The Matrix is the only one that has this problem.  The 
problem also occurs with 2.4.9.

Hope this helps.  If there's anything else I can do let me know.

Rich


