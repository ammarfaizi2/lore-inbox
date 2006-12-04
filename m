Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936889AbWLDOUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936889AbWLDOUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936890AbWLDOUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:20:05 -0500
Received: from smtp151.iad.emailsrvr.com ([207.97.245.151]:16800 "EHLO
	smtp151.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S936889AbWLDOUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:20:04 -0500
Message-ID: <45742CAE.80109@gentoo.org>
Date: Mon, 04 Dec 2006 09:11:58 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: sam@ravnborg.org, linux-kernel@vger.kernel.org, miraze@web.de
Subject: Re: [PATCH] kbuild: Write astest files to $(KBUILD_EXTMOD) directory
References: <20061202194544.D9F057B40A0@zog.reactivated.net> <20061204004503.11c1d6df.akpm@osdl.org>
In-Reply-To: <20061204004503.11c1d6df.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> What's the relationship between this patch and the fixes in this area in -mm?

I was unaware of those.

The first patch in -mm is obviously broken but is fixed by the 2nd one. 
The combination of both looks OK to me. I'm happy for either approach to 
be merged, it will make the problem go away.

Sam, please comment.

Daniel

