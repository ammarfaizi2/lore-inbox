Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVKHVWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVKHVWu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030368AbVKHVWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:22:49 -0500
Received: from xenotime.net ([66.160.160.81]:54690 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030367AbVKHVWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:22:49 -0500
Date: Tue, 8 Nov 2005 13:22:45 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan Beulich <JBeulich@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: export genapic again
In-Reply-To: <4370AEE1.76F0.0078.0@novell.com>
Message-ID: <Pine.LNX.4.58.0511081321390.15288@shark.he.net>
References: <4370AEE1.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Jan Beulich wrote:

> A change not too long ago made i386's genapic symbol no longer be
> exported, and thus certain low-level functions no longer be usable.
> Since close-to-the-hardware code may still be modular, this
> rectifies the situation.
>
> From: Jan Beulich <jbeulich@novell.com>
>
> (actual patch attached)

Having no attachments would be preferable, but if you must use
attachments, having them marked as plain text instead of
"octet-stream" would be a great improvement.

Thanks.
-- 
~Randy
