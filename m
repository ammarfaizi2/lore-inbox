Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbUCKHuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 02:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbUCKHuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 02:50:06 -0500
Received: from [212.239.225.213] ([212.239.225.213]:18306 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S261615AbUCKHt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 02:49:57 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.4
Date: Thu, 11 Mar 2004 08:49:43 +0100
User-Agent: KMail/1.6.1
References: <Pine.LNX.4.58.0403101924510.3693@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403101924510.3693@ppc970.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403110849.43527.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 March 2004 04:28, Linus Torvalds wrote:
> A few small fixes since -rc3, most notably an OHCI bug that would corrupt
> memory and seems to have been the reason for the "Bad page flags" bug at
> least on ppc64 (it's not been reported on x86, as far as I know, but I
> don't see why the corruption couldn't have happened there too).
>
> The full changelog from 2.6.3 is on the ftp-sites along with the patches
> and tar-balls, and the BK trees have been updated.
>
> 			Linus

Just upgraded from 2.6.2 to 2.6.4. The new -mregparm=3 support, how likely is 
it to totally break one's system? I'm not really in the mood to trash boxes 
today ;p

Jan


-- 
Innocence ends when one is stripped of the delusion that one likes oneself.
		-- Joan Didion, "On Self Respect"
