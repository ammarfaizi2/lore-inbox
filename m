Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbVJUMdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbVJUMdS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbVJUMdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:33:18 -0400
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:36615 "EHLO
	anchor-post-31.mail.demon.net") by vger.kernel.org with ESMTP
	id S964919AbVJUMdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:33:17 -0400
From: Felix Oxley <lkml@oxley.org>
To: "venkata jagadish.p" <cpvjagadeesh@gmail.com>
Subject: Re: Regarding RT patches
Date: Fri, 21 Oct 2005 13:33:01 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <4358B78C.2030708@gmail.com>
In-Reply-To: <4358B78C.2030708@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510211333.02214.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I would like to (hijack) add some (newbie) questions of my own to this thread, since it has a useful title.
I hope that's OK. :-)

If there is any source of info discussing these issues on the net already please feel free to point me to it.

1.  I have seen that the testers have been carefully setting the priority of tasks so that a particular
     application comes top, followed by 1 or 2 IRQs and then maybe a hard disk etc.
     What is the effect of the RT patchset if the user takes no action to set the correct priority of their tasks?

2. Imagining that distribution X shipped with RT as configurable option defaulted to OFF, which users should
    would be advised to enable it?

3. Imagining that distribution X shipped with RT as configurable option defaulted to ON, which users should
    would be advised to disable it?

4. For completeness, that would leave certain classes of users for whom it was irrelevant/unclear whether they
   should enable/disable RT. Those classes comprising who?


Thanks,
Felix

(I hope that nobody finds it necessary to turn this thread into a flamewar. Please?  :-)





