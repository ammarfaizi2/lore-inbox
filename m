Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVGZBfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVGZBfj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 21:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVGZBfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 21:35:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26250 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261523AbVGZBff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 21:35:35 -0400
Date: Mon, 25 Jul 2005 18:34:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miles Bader <miles@gnu.org>
Cc: miles@lsi.nec.co.jp, torvalds@osdl.org, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org, vincent.hanquez@cl.cam.ac.uk, ak@suse.de
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
Message-Id: <20050725183413.08ed2a5f.akpm@osdl.org>
In-Reply-To: <buoll3upd84.fsf@mctpc71.ucom.lsi.nec.co.jp>
References: <200507251901_MC3-1-A589-A433@compuserve.com>
	<Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
	<buoll3upd84.fsf@mctpc71.ucom.lsi.nec.co.jp>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader <miles@lsi.nec.co.jp> wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
>  > Ask a hundred random C programmers what "!!x" means, versus what "x != 0"
>  > means, and time their replies.
> 
>  I've always thought of "!!" as the "canonicalize boolean" operator...

Me too.  Once you get used to it, it's just the "convert non-zero to 1"
operator.

But whatever.
