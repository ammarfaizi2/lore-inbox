Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262101AbTK1J73 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 04:59:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTK1J73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 04:59:29 -0500
Received: from h192n2fls310o1003.telia.com ([81.224.187.192]:57472 "EHLO
	cambrant.com") by vger.kernel.org with ESMTP id S262101AbTK1J72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 04:59:28 -0500
Date: Fri, 28 Nov 2003 11:57:50 +0100
From: Tim Cambrant <tim@cambrant.com>
To: mru@kth.se
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange behavior observed w.r.t 'su' command
Message-ID: <20031128105750.GA5777@cambrant.com>
References: <3FC707B6.1070704@mailandnews.com> <yw1xekvs3lbt.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xekvs3lbt.fsf@kth.se>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 28, 2003 at 10:15:50AM +0100, M?ns Rullg?rd wrote:
> I can't reproduce it on Slackware running 2.6.0-test10.  It's probably
> a redhat thing.

This problem also appears on Gentoo 1.4 running 2.6.0-test11. I don't
know about the rest of the environment, but it's definately not just
a RedHat thing. Could it have something to do with some library-version
or something?

-- 
Tim Cambrant <tim@cambrant.com> 
GPG KeyID 0x59518702
Fingerprint: 14FE 03AE C2D1 072A 87D0  BC4D FA9E 02D8 5951 8702
