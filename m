Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263579AbTH0QCr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263580AbTH0QCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:02:46 -0400
Received: from holomorphy.com ([66.224.33.161]:34744 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263579AbTH0QBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:01:34 -0400
Date: Wed, 27 Aug 2003 09:02:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: warudkar@vsnl.net
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: your mail
Message-ID: <20030827160233.GE4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	warudkar@vsnl.net, kernel@kolivas.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <200308280225.h7S2PNa26057@webmail2.vsnl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308280225.h7S2PNa26057@webmail2.vsnl.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 09:25:23PM -0500, warudkar@vsnl.net wrote:
> Con - With swappiness set to 100, the apps do start up in 3 minutes and kswapd doesn't hog the CPU. But X is still unusable till all of them have started up.
> Wli - Sorry, vmstat segfaults on 2.6!

This is a bug in older versions of vmstat. Upgrade vmstat.


-- wli
