Return-Path: <linux-kernel-owner+w=401wt.eu-S1755394AbXABRTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbXABRTJ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 12:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbXABRTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 12:19:09 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:1497 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755394AbXABRTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 12:19:07 -0500
Subject: Re: Nothing since 2.6.19 will boot for me.
References: <microsoft-free.87odphsx40.fsf@youngs.au.com>
From: Paul Slootman <paul+nospam@wurtel.net>
Organization: Wurtelization
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Date: 02 Jan 2007 17:18:55 GMT
Message-ID: <459a93ff$0$335$e4fe514c@news.xs4all.nl>
X-Trace: 1167758335 news.xs4all.nl 335 [::ffff:83.68.3.130]:45952
X-Complaints-To: abuse@xs4all.nl
In-Reply-To: <microsoft-free.87odphsx40.fsf@youngs.au.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Youngs  <steve@youngs.au.com> wrote:
>
>The last kernel from Linus' tree[1] that boots for me is v2.6.19.  And
>before I take my first stab at git-bisect, I thought I'd ask here in
>case it's just a PEBCAK.
>
>What happens in kernels since v2.6.19 is:
>
>  o Choose the kernel to boot from lilo menu
>
>  o Lilo prints the first 2 lines of it's output
>
>        imagename.....................................
>        Bios data something or other (sorry, too quick for me to catch
>          what it actually says)
>
>  o At this point the machine reboots (right back to the video card
>    copyright/splash)

What is your boot string?
It sounds a lot like http://bugzilla.kernel.org/show_bug.cgi?id=7505


Paul Slootman
