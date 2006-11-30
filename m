Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759200AbWK3JOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759200AbWK3JOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 04:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759208AbWK3JOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 04:14:18 -0500
Received: from twin.jikos.cz ([213.151.79.26]:12252 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1759207AbWK3JOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 04:14:16 -0500
Date: Thu, 30 Nov 2006 10:14:05 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ian Kent <raven@themaw.net>
cc: Andrew Morton <akpm@osdl.org>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs: fix error code path in autofs_fill_sb()
In-Reply-To: <1164863675.3127.4.camel@localhost>
Message-ID: <Pine.LNX.4.64.0611301012340.28502@twin.jikos.cz>
References: <Pine.LNX.4.64.0611300123160.28502@twin.jikos.cz>
 <1164863675.3127.4.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006, Ian Kent wrote:

> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Ian Kent <raven@themaw.net>
> It looks so obvious now.
> Updating the comment above would be a good idea also, see attached.

Yes, I agree. Andrew, could you please apply it on top of my fix?

Thanks,

-- 
Jiri Kosina
