Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313541AbSDHIyY>; Mon, 8 Apr 2002 04:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313593AbSDHIyX>; Mon, 8 Apr 2002 04:54:23 -0400
Received: from [151.200.199.53] ([151.200.199.53]:22024 "EHLO fc.Capaccess.org")
	by vger.kernel.org with ESMTP id <S313541AbSDHIyX>;
	Mon, 8 Apr 2002 04:54:23 -0400
Message-id: <fc.00858412003a781000858412003a7810.3a7819@Capaccess.org>
Date: Mon, 08 Apr 2002 04:53:54 -0400
Subject: Forth interpreter as kernel module
To: linux-kernel@vger.kernel.org
From: "Rick A. Hohensee" <rickh@Capaccess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Segher Boessenkool
 >  I'm writing a full OF implementation for OpenBios. It will also be
  > able to run in user space, which might be a better solution for things
   >like softboot (and besides, it makes development a lot easier).

For in-kernel User Mode Linux might help. Jeff Dike suggested that to me
at H3rL announce time. Valid suggestion, just not the tendency of a guy
that writes an in-kernel 3-stack Forth in pure assembly and doesn't put
Perl in his distro.

Rick Hohensee

