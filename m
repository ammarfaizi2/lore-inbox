Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUEFXp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUEFXp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 19:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262272AbUEFXp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 19:45:58 -0400
Received: from are.twiddle.net ([64.81.246.98]:62085 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262176AbUEFXpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 19:45:54 -0400
Date: Thu, 6 May 2004 16:45:25 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] get rid of "+m" constraint in i386 rwsems
Message-ID: <20040506234525.GA25966@twiddle.net>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4955.1083844733@redhat.com> <Pine.LNX.4.58.0405060740200.3271@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405060740200.3271@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 07:42:51AM -0700, Linus Torvalds wrote:
> If it's just a warning in 3.4, and later gcc's are supposed to make it ok 
> again, then..

Sorry about taking so long to get to this.  It's now fixed for
tree-ssa branch (to be merged to mainline this week) and for
gcc 3.4.1.  Too late for 3.4.0, however...



r~
