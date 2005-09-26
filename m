Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932336AbVIZWBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932336AbVIZWBB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVIZWBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:01:01 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932336AbVIZWBA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:01:00 -0400
Date: Mon, 26 Sep 2005 15:00:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Danny ter Haar <dth@cistron.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: just a report: 2.6.14-rc2-git[35] (UP) not stable on usenet
 server  where 2.6.12 stays up for weeks
In-Reply-To: <dh9msb$ko0$1@news.cistron.nl>
Message-ID: <Pine.LNX.4.58.0509261459530.3308@g5.osdl.org>
References: <dh9msb$ko0$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Sep 2005, Danny ter Haar wrote:
> 
> I've announced it probably all to often.
> But 2.6.1[34]* kernels aren't stable for me.
> Where 2.6.12-mm1 stays up for >> 3 weeks the latest kernels barfs:

Really need to narrow this down a lot more. Either a oops from a serial 
port, or pinpointing where it started happening.

		Linus
