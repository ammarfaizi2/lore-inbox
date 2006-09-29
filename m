Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161519AbWI2IgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161519AbWI2IgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161410AbWI2IgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 04:36:11 -0400
Received: from rtr.ca ([64.26.128.89]:28940 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1030412AbWI2IgH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 04:36:07 -0400
Message-ID: <451CDAF5.1@rtr.ca>
Date: Fri, 29 Sep 2006 04:36:05 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Arrr! Linux 2.6.18
References: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609192126070.4388@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mmm.. definite regression with -final versus -rc6.

My Latitude-X1 notebook loses video on resume-from-ram
with -final.  Worked fine with all versions from 2.6.16
through 2.6.18-rc6.  So something at the last moment broke it.

I'm travelling with it all this month, with only occasional
access here.  But any suggestions of *specific* patches to
try reverting would be welcome.  git-bisect is a non-starter.

Cheers

Mark Lord
