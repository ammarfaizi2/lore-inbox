Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264866AbUD2PSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264866AbUD2PSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 11:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbUD2PSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 11:18:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21639 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264881AbUD2POz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 11:14:55 -0400
Date: Thu, 29 Apr 2004 11:14:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Timothy Miller <miller@techsource.com>
cc: Marc Boucher <marc@linuxant.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <40911C01.80609@techsource.com>
Message-ID: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Apr 2004, Timothy Miller wrote:

> > "Due to $MOD_FOO's license ($BLAH), the Linux kernel community
> > cannot resolve problems you may encounter. Please contact
> > $MODULE_VENDOR for support issues."
> 
> Sounds very "politically correct", but certainly more descriptive and 
> less alarming.

More importantly, it directs the support burden to where
it, IMHO, belongs.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

