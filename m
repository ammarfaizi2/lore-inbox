Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270480AbTHCB6N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 21:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270517AbTHCB6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 21:58:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:38308 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270480AbTHCB6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 21:58:11 -0400
Date: Sat, 2 Aug 2003 18:59:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: shrybman@sympatico.ca, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm3 and mysql
Message-Id: <20030802185911.447d4ad9.akpm@osdl.org>
In-Reply-To: <200308031152.17070.kernel@kolivas.org>
References: <1059871132.2302.33.camel@mars.goatskin.org>
	<20030802180410.265dfe40.akpm@osdl.org>
	<200308031152.17070.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> On Sun, 3 Aug 2003 11:04, Andrew Morton wrote:
> > Shane Shrybman <shrybman@sympatico.ca> wrote:
> > > mysql doesn't start on this kernel.
> [snip self abuse...]
> 
> Would this also be why I get lots of this error on this kernel?
> 
> diff: standard output: Input/output error
> 

Yes.  Silly last-minute thing.  Sorry about that.

I'll remove 2.6.0-test2-mm3 and will upload a 2.6.0-test2-mm3-1
