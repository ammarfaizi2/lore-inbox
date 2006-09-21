Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751686AbWIUWZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751686AbWIUWZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbWIUWZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:25:57 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:39962 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751583AbWIUWZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:25:56 -0400
Message-ID: <BAYC1-PASMTP04A6968C3ABEA48C9AD2E5AE200@CEZ.ICE>
X-Originating-IP: [65.94.249.130]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Thu, 21 Sep 2006 18:25:54 -0400
From: Sean <seanlkml@sympatico.ca>
To: David Lang <dlang@digitalinsight.com>
Cc: Dax Kelson <dax@gurulabs.com>,
       Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
Message-Id: <20060921182554.23044ca3.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
References: <1158870777.24172.23.camel@mentorng.gurulabs.com>
	<20060921204250
 .GN13641@csclub.uwaterloo.ca>
	<20060921171747.9ae2b42e.seanlkml@sympatico.ca>
	<1158874875.24172.47.camel@mentorng.gurulabs.com>
	<BAYC1-PASMTP025A72C81CFE009C3BB5A5AE200@CEZ.ICE>
	<20060921175717.272c58ee.seanlkml@sympatico.ca>
	<Pine.LNX.4.63.0609211455570.17238@qynat.qvtvafvgr.pbz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.10.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Sep 2006 22:25:56.0494 (UTC) FILETIME=[E82C92E0:01C6DDCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 15:00:48 -0700 (PDT)
David Lang <dlang@digitalinsight.com> wrote:

> yes,
>    however git users are people who plan on following every kernel version for a 
> while, tarball users are people who grab a copy of the kernel once in a while 
> (probably not every version). for the tarball users they would have to grab 
> multiple patches to get from the last thing that they have to whatever is 
> current. and frankly they may not (and probably should not) trust the last thing 
> that they have, as in many cases it's a distro patched kernel that may not be 
> compatable with the vanilla kernel.
>
> people who start downloading every revision should start useing git or patches, 
> but not everyone needs it.

Agreed, but for those people there isn't going to be much need (if any) to
worry about if the tar ball is in .gzip or .bzip2 or whatever then either.  And
that was the case that inspired the suggestion.
 
> also people could be behind a firewall that prevents git from working properly, 
> for them tarballs and patches are the right way of doing things.

I use git from behind a firewall everyday without a problem.  If you've seen
such a problem yourself, a bug report would hopefully lead to a solution.

Thanks,
Sean
