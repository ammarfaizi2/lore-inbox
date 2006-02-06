Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750914AbWBFKJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750914AbWBFKJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750923AbWBFKJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:09:58 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:30604 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1750914AbWBFKJ6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:09:58 -0500
To: rjwalsh@durables.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about RCS keywords
References: <52970.72.254.5.223.1139219753.squirrel@www.durables.org>
From: Jes Sorensen <jes@sgi.com>
Date: 06 Feb 2006 05:09:57 -0500
In-Reply-To: <52970.72.254.5.223.1139219753.squirrel@www.durables.org>
Message-ID: <yq08xsool1m.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Robert" == Robert Walsh <rjwalsh@durables.org> writes:

Robert> Hi, I notice some files in the kernel have RCS keywords in
Robert> them: look at kernel/dma.c, for example.  Most files don't.
Robert> What's the policy on this?

Robert,

The general consensus seems to be that it's fine to have it as long as
you make sure not to push out patches changing it all the time. Ie. if
you don't own the file, you don't change the RCS tag in it.

Cheers,
Jes
