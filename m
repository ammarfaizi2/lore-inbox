Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277191AbRJLDqQ>; Thu, 11 Oct 2001 23:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277194AbRJLDqG>; Thu, 11 Oct 2001 23:46:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33396 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S277191AbRJLDp4>; Thu, 11 Oct 2001 23:45:56 -0400
Date: Fri, 12 Oct 2001 05:45:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Oleg A. Yurlov" <kris@spylog.com>
Cc: linux-kernel@vger.kernel.org, mantel@suse.de
Subject: Re: 2.4.7 from updates for SuSE 7.2 - crash.
Message-ID: <20011012054558.W714@athlon.random>
In-Reply-To: <159543829765.20011011233216@spylog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159543829765.20011011233216@spylog.com>; from kris@spylog.com on Thu, Oct 11, 2001 at 11:32:16PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2001 at 11:32:16PM +0400, Oleg A. Yurlov wrote:
> 
>         Hi, Hubert, Andrea and all,
> 
>         My server crashed again...
> 
>         Symptom: procfs die, processes unaccessible...

could be the down_read recursion. Many bugs are been fixed after 2.4.7.

Can you try if you can reproduce with Hubert's latest kernel based on
2.4.12aa1? thanks!

Andrea
