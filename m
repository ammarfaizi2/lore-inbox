Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbTJJLzv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 07:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbTJJLzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 07:55:51 -0400
Received: from frontend-1.hamburg.de ([212.1.41.126]:15758 "EHLO
	ebbe.int-rz.hamburg.de") by vger.kernel.org with ESMTP
	id S261239AbTJJLzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 07:55:50 -0400
Message-ID: <1239031.1065786947952.JavaMail.nobody@franzjosef>
Date: Fri, 10 Oct 2003 13:55:47 +0200 (CEST)
Illegal-Object: Syntax error in From: address found on vger.kernel.org:
	From:	"Dieter  =?ISO-8859-1?Q?=20N=FCtzel=22?= <dieter.nuetzel@hamburg.de>"
			^-missing closing '"' in token
From: linux-kernel-owner@vger.kernel.org
To: Nikita@Namesys.COM
Subject: Re: Re: File System shootout...
Cc: linux-kernel@vger.kernel.org, mikeb@netnation.com,
       Reiserfs-List@Namesys.COM
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: SNetLine WebMail by Schliepi
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Mike Benoit writes:
>  > To all those who are interested, here are the results of the benchmarks
>  > I've been running over the last week between all the major file systems
>  > (and there different mount options) using both Bonnie++ and IOzone. More
>  > tests are currently underway, so the results will be updated as they
>  > come in. 
>  > 
>  > Hopefully these results will give you a good comparative overview of each of the
>  > different file systems strengths and weaknesses.
>  > 
>  > http://fsbench.netnation.com/
> 
> I should probably add that I am getting quite different bonnie++ results
> for reiser4 vs. ext3:
> 
> on the box with 128M of ram:

Why no numbers for ReiserFS 3.xx plus data-logging patch (odered/journal/writeback, e.g. current code) like ext3?

Greetings,
   Dieter
