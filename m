Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261502AbULBAG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261502AbULBAG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 19:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261527AbULBADp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 19:03:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261515AbULAX64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:58:56 -0500
Date: Wed, 1 Dec 2004 15:58:46 -0800
Message-Id: <200412012358.iB1Nwk3C002166@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: joe.korty@ccur.com
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: waitid breaks telnet
In-Reply-To: Joe Korty's message of  Wednesday, 1 December 2004 18:22:04 -0500 <20041201232204.GA29829@tsunami.ccur.com>
Emacs: an inspiring example of form following function... to Hell.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since I can only manage so far to see this once in a blue moon, and you can
produce it frequently, it would be helpful if you can diagnose the problem
some.  That is, figure out exactly what wrong results from a wait* call is
at fault.


Thanks,
Roland
