Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268348AbUHXViA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268348AbUHXViA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUHXVh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:37:59 -0400
Received: from mail3.speakeasy.net ([216.254.0.203]:30189 "EHLO
	mail3.speakeasy.net") by vger.kernel.org with ESMTP id S268348AbUHXVex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:34:53 -0400
Date: Tue, 24 Aug 2004 14:34:49 -0700
Message-Id: <200408242134.i7OLYnuQ026343@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: "Wilkerson, Bryan P" <Bryan.P.Wilkerson@intel.com>
X-Fcc: ~/Mail/linus
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: EINTR causes sigwaitinfo and pthread_kill to become hosed
In-Reply-To: Wilkerson, Bryan P's message of  Tuesday, 24 August 2004 08:28:31 -0700 <194B303F2F7B534594F2AB2D87269D9F0267394B@orsmsx408>
X-Zippy-Says: LOU GRANT froze my ASSETS!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you reproduced this on 2.6.8.1?  I'm not seeing it so far.


Thanks,
Roland
