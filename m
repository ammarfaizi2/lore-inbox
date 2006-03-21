Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030399AbWCUOR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWCUOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 09:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWCUOR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 09:17:28 -0500
Received: from mail.gmx.de ([213.165.64.20]:1683 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030399AbWCUOR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 09:17:26 -0500
X-Authenticated: #14349625
Subject: Re: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: Willy Tarreau <willy@w.ods.org>, Ingo Molnar <mingo@elte.hu>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       bugsplatter@gmail.com
In-Reply-To: <200603220053.53595.kernel@kolivas.org>
References: <1142592375.7895.43.camel@homer>
	 <20060321125900.GA25943@w.ods.org> <1142947456.7807.53.camel@homer>
	 <200603220053.53595.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 15:17:31 +0100
Message-Id: <1142950651.7807.95.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-22 at 00:53 +1100, Con Kolivas wrote:
> The yardstick for changes is now the speed of 'ls' scrolling in the console. 
> Where exactly are those extra cycles going I wonder? Do you think the 
> scheduler somehow makes the cpu idle doing nothing in that timespace? Clearly 
> that's not true, and userspace is making something spin unnecessarily, but 
> we're gonna fix that by modifying the scheduler.... sigh

*Blink*

Are you having a bad hair day??

	-Mike

