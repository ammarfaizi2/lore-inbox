Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272656AbTG1E1D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 00:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272657AbTG1E1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 00:27:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:18870 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272656AbTG1E1B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 00:27:01 -0400
Date: Sun, 27 Jul 2003 21:42:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marino Fernandez <mjferna@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory runs out fast with 2.6.0-test2 (and test1)
Message-Id: <20030727214218.5b8148fb.akpm@osdl.org>
In-Reply-To: <200307272335.55550.mjferna@yahoo.com>
References: <200307272117.23398.mjferna@yahoo.com>
	<20030727205912.1bb4a635.akpm@osdl.org>
	<200307272335.55550.mjferna@yahoo.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marino Fernandez <mjferna@yahoo.com> wrote:
>
> On Sunday 27 July 2003 10:59 pm, Andrew Morton wrote:
>  > Marino Fernandez <mjferna@yahoo.com> wrote:
>  > > Everything works OK in my system... my only gripe is that I run out of
>  > > memory quickly.
>  >
>  > Please monitor /proc/meminfo and /proc/slabinfo, see if you can work out
>  > where the memory has gone and post the results.
>  >
>  > What filesystems are you using there?
> 
>  ext3
> 
>  The rest of the info is attached

I see no problem.  There are no large unreclaimable caches, there has been
no swapout.

Either you need to describe the problem a little more completely, or the
info which you sent was not gathered at the correct time.

