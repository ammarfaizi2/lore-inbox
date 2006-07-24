Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932277AbWGXWOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbWGXWOn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 18:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWGXWOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 18:14:43 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:2358 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932277AbWGXWOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 18:14:42 -0400
Message-ID: <44C54818.6000201@gentoo.org>
Date: Mon, 24 Jul 2006 23:22:16 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.[1-6] XFS Filesystem Corruption, Where is 2.6.17.7?
References: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0607241224010.10896@p34.internal.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Beginning at 2.6.17 to 2.6.17.6, there is a serious XFS bug that results 
> in filesystem corruption, there was a 1 line bugfix patch that was 
> released recently and I was wondering when 2.6.17.7 would be released 
> with that patch?  It affected ALL my Linux machines (x86) running XFS 
> and many people on the XFS mailing list who upgraded to 2.6.17.  I 
> understand when there is a root exploit or DoS bug, the kernel is 
> naturally patched by the -stable team and a new version is released 
> immediately.  Does filesystem corruption not constitute an immediate new 
> -stable release of the kernel?

Greg has been too busy at OLS, expect it in the next few days.

Additionally, some problems have been reported with the forty-something 
patches that were posted for review. If you want to help, apply all of 
those patches on top of 2.6.17.6 and see if you can find any problems.

Daniel
