Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130900AbRDYSes>; Wed, 25 Apr 2001 14:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131157AbRDYSei>; Wed, 25 Apr 2001 14:34:38 -0400
Received: from smarty.smart.net ([207.176.80.102]:42514 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S130900AbRDYSeT>;
	Wed, 25 Apr 2001 14:34:19 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200104251834.OAA04501@smarty.smart.net>
Subject: Re: [PATCH] Single user linux
To: linux-kernel@vger.kernel.org
Date: Wed, 25 Apr 2001 14:34:50 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



imel96@trustix.co.id wrote:
> for those who didn't read that patch, i #define capable(),
> suser(), and fsuser() to 1. the implication is all users
> will have root capabilities.

How is that not single user?

I have been doing single-user oriented Linux/GNU/unix longer than anyone
I'm aware of with exactly that focus. The one trivial patch I do to the
kernel disgusts the core Linux developers for reasons unrelated to single
user.  cLIeNUX boots with 12 vt's logging in already as root. No kernel
molestation. (But stay tuned ;o) Rather than me contributing further to
the topic-skew, please have a browse at

	www.clienux.com


Rick Hohensee
cLIeNUX user 0
