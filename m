Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269340AbUJQXUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269340AbUJQXUW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 19:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269333AbUJQXRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 19:17:45 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:15264 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269335AbUJQXPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 19:15:52 -0400
Subject: Re: [patch] exec-shield-nx-2.6.9-A1
From: Albert Cahalan <albert@users.sf.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20041017203055.GA10403@elte.hu>
References: <1098043886.2674.14320.camel@cube>
	 <20041017203055.GA10403@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1098054529.2666.14326.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2004 19:08:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-10-17 at 16:30, Ingo Molnar wrote:

> > [...] One might guess from CAP_SYS_NICE that the feature has now
> > become hopelessly slow. [...]
> 
> (thank you for the kind words, it is always heartening to read your
> mails! I too wish you good luck with your projects.)

:-)

Well, CAP_SYS_NICE does kind of imply that there is
an issue with CPU time, doesn't it? I didn't see any
code that would change performance, so I suppose you
figure that wchan is already too slow?

CAP_SYS_ADMIN is the misc. dumping ground normally.



