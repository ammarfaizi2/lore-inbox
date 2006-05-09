Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWEIXJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWEIXJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbWEIXJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 19:09:21 -0400
Received: from ns.suse.de ([195.135.220.2]:26582 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932065AbWEIXJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 19:09:21 -0400
From: Andi Kleen <ak@suse.de>
To: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [RFC PATCH 25/35] Add Xen time abstractions
Date: Wed, 10 May 2006 01:09:14 +0200
User-Agent: KMail/1.9.1
Cc: virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
References: <20060509084945.373541000@sous-sol.org> <200605092350.03886.ak@suse.de> <200605100103.54875.ioe-lkml@rameria.de>
In-Reply-To: <200605100103.54875.ioe-lkml@rameria.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605100109.15038.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Isn't time and timer handling a moving target anyway?
> The refactoring will be done by the timer people in a completly different
> manner anyway.
> 
> Are you sure, you want to disturb these efforts by requiring another
> refactoring here?

Yes I am.

-Andi
