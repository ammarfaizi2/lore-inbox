Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbTJYXpL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 19:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262894AbTJYXpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 19:45:11 -0400
Received: from 217-124-6-235.dialup.nuria.telefonica-data.net ([217.124.6.235]:14213
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S262893AbTJYXpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 19:45:08 -0400
Date: Sun, 26 Oct 2003 01:45:07 +0200
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test9
Message-ID: <20031025234507.GB15889@localhost>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310251152410.5764-100000@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 25 October 2003, at 12:09:10 -0700,
Linus Torvalds wrote:

> If it corrupts data, is a security issue, or causes lockups or just basic
> nonworkingness: and this happens on hardware that _normal_ people are
> expected to have, then it's critical.  Otherwise, it's noise and should
> wait.
> 
With respect to security issues, there have been some of them in the past
months, and at least some of them were not fixed back them with the
argument of "development release, will be fixed".

It seems that Alan Cox was the one to keep track of these security
problems, but now that he is on his sabbatical year maybe some of the
fixes are still pending, because nobody remembers there were any ;-)

Are these problems already fixed, and I missed them, or there are still
some to be addressed ?.

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test8-mm1)
