Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTEUH7H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbTEUHzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:55:48 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261769AbTEUHnY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:24 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Tue, 20 May 2003 17:05:02 MST."
             <3ECAC2AE.8090401@redhat.com> 
Date: Wed, 21 May 2003 12:34:50 +1000
Message-Id: <20030521023627.F07062C015@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3ECAC2AE.8090401@redhat.com> you write:
> Ingo's last patch is just fine.  New functionality should not be added
> to the to-be-obsoleted interfaces.

Perhaps I was reading too much into Linus' mail, but I read it as
"don't obsolete the old interface and introduce a new one just because
of some sense of aesthetics".

ie. it's not a to-be-obsoleted interface.

I think we're long past this being a productive thread, though.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
