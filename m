Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267483AbUJLSXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267483AbUJLSXs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUJLSOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:14:39 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:14556 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266572AbUJLSMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:12:55 -0400
Subject: Re: CD/DVD burn failed from non root user
From: Lee Revell <rlrevell@joe-job.com>
To: viaprog@lic1.vsi.ru
Cc: linux-kernel <linux-kernel@vger.kernel.org>, superpunk <unixuser@mail.ru>,
       Sergey Kondratiev <serkon@box.vsi.ru>, semen@basdesign.ru
In-Reply-To: <1097548634.1440.6.camel@krustophenia.net>
References: <416B4004.7050309@lic1.vsi.ru>
	 <1097548634.1440.6.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1097604288.1553.53.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 12 Oct 2004 14:04:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-10-11 at 22:37, Lee Revell wrote:
> On Mon, 2004-10-11 at 22:23, Igor A. Valcov wrote:
> > And in general it would be quite good to solve this problem in a 
> > civilized way :)
> 
> Also, this is hard to do when your mail server blocks me with "553 5.3.0
> REJECT Spam not accepted".  Please fix your filter, I am not running a
> spamhaus here.
> 

Here is my reply.  Your spam filter is STILL bouncing my mail.

--

Are you saying DCANet is a spamhaus?  That is crazy, we are an ISP with
15,000 customers, of course you have received spam from them once or
twice.  All we can do when we catch a customer spamming (usually due to
a hacked machine) is terminate their access.  We cannot go back in time
and un-send the spam.

I have never had anyone on LKML bounce mail from DCANet.  So, the
problem is at YOUR END.

If you are accusing DCANet of being a spamhaus then please forward me
one shred of evidence that DCANet has ever spammed you.

--

Anyway, just to keep this thread from being a completely OT waste of
time, the code that your patch removes was put there for a reason.  It
fixes a security hole.  There was a long thread about it on LKML last
month.  Posting a patch that just rips this code out is not productive.

Lee 

