Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbTGKDFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 23:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269768AbTGKDF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 23:05:29 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:42736 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S266597AbTGKDF1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 23:05:27 -0400
Subject: Re: [PATCH/RFC] Deprecate sysctl(2), add sysctl_name
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org>
References: <Pine.LNX.4.44.0307101932510.5551-100000@home.osdl.org>
Content-Type: text/plain
Message-Id: <1057893842.5095.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 10 Jul 2003 20:24:02 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-10 at 19:35, Linus Torvalds wrote:

> I doubt there is any real reason to not just use the /proc interface, and 
> I dislike pre-emptive engineering.

Agreed.

Further, as someone working on embedded, I think requiring /proc is fine
for this.

	Robert Love


