Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUFBOLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUFBOLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 10:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262902AbUFBOLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 10:11:10 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:59609 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262882AbUFBOLI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 10:11:08 -0400
X-AuthUser: davidel@xmailserver.org
Date: Wed, 2 Jun 2004 07:11:05 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Vadim Lobanov <vadim@cs.washington.edu>
cc: jyotiraditya@softhome.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Select/Poll
In-Reply-To: <20040601235641.M6580-100000@attu2.cs.washington.edu>
Message-ID: <Pine.LNX.4.58.0406020708370.22204@bigblue.dev.mdolabs.com>
References: <20040601235641.M6580-100000@attu2.cs.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2004, Vadim Lobanov wrote:

> scalability much. If you _really_ want to, however, check epoll - should 
> be standardized on the 2.6.x kernels (though my glibc still has VERY big 
> issues with it).

(s/should/is/)
The "very BIG issues" statement is kinda hard to debug. Did you try to 
report you issues here (if kernel related) or to the glibc mailing list?



- Davide

