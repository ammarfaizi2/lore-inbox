Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWEEVSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWEEVSq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 17:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbWEEVSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 17:18:46 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:42763 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751217AbWEEVSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 17:18:45 -0400
Date: Fri, 5 May 2006 23:18:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Merillat <harik.attar@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@googlemail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kbuild + Cross compiling
Message-ID: <20060505211845.GA24572@mars.ravnborg.org>
References: <c0c067900605041852m50e04171x7fd1579e77c9d5a3@mail.gmail.com> <6e0cfd1d0605050736g624c2a6fm68ab8b659fa6e253@mail.gmail.com> <c0c067900605051353k53e74fdeo5caed2b9621091d5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0c067900605051353k53e74fdeo5caed2b9621091d5@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2006 at 04:53:36PM -0400, Dan Merillat wrote:
> 
> That was it.  debian make 3.80 was buggy.   Since make was a likely
> culprit I upgraded it anyway, then I read this and it confirmed what I
> found.
If debian reports make 3.80-rc1 as 3.80 then either debian or make has a
problem.

	Sam
