Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUD1Xyt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUD1Xyt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 19:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUD1Xyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 19:54:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32437 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261931AbUD1Xys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 19:54:48 -0400
Date: Wed, 28 Apr 2004 19:54:43 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marc Boucher <marc@linuxant.com>
cc: Tom Sightler <ttsig@tuxyturvy.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
In-Reply-To: <CA90E50C-9932-11D8-85DF-000A95BCAC26@linuxant.com>
Message-ID: <Pine.LNX.4.44.0404281953180.19633-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Apr 2004, Marc Boucher wrote:

> The problem goes both ways. Non-standard, unreported and hard to detect
> kernel patches have caused numerous users to report alleged driver bugs
> to us. You wouldn't know how much time and resources these things cost
> us.

The problem shouldn't be going both ways, though.

It is your decision to publish a module that taints
the kernel, so the support burden should not fall on
the kernel community...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

