Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVEIVZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVEIVZR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 17:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVEIVZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 17:25:17 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:58554 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261531AbVEIVZN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 17:25:13 -0400
Message-Id: <427FD554.5030207@khandalf.com>
Date: Mon, 09 May 2005 23:25:40 +0200
From: "Brian O'Mahoney" <omb@khandalf.com>
Reply-To: omb@bluewin.ch
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/cpuinfo format - arch dependent!
References: <20050508012521.GA24268@SDF.LONESTAR.ORG>
    <427FA876.7000401@tmr.com> <427FC366.1000506@nortel.com>
    <20050509202637.GF2297@csclub.uwaterloo.ca>
In-Reply-To: <20050509202637.GF2297@csclub.uwaterloo.ca>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Md5-Body: 38fe151fd5e53e3ab3a8ae53fc1da1fe
X-Transmit-Date: Monday, 9 May 2005 23:25:48 +0200
X-Message-Uid: 0000b49cec9d5a3f0000000200000000427fd55c0008a61f00000001000a2697
Replyto: omb@bluewin.ch
X-Sender-Postmaster: Postmaster@80-218-57-125.dclient.hispeed.ch.
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't want to butt in on a private fight but, philosophically,
I would argue that it is up to the kernel to report the real
hardware configuration in an easy to use, and extensible, way.

This only needs to be done once. To argue about what application
writers could or should use, based on what happens today is
just a cop-out; the only thing one must say is that if the app
dosn't understand the architecture it must provide defaults.

- Brian
