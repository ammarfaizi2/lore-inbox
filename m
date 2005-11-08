Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVKHQ7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVKHQ7E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 11:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVKHQ7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 11:59:04 -0500
Received: from xenotime.net ([66.160.160.81]:55712 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964907AbVKHQ7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 11:59:03 -0500
Date: Tue, 8 Nov 2005 08:59:02 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan Beulich <JBeulich@novell.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: make trap information available to die handlers
In-Reply-To: <4370E5C4.76F0.0078.0@novell.com>
Message-ID: <Pine.LNX.4.58.0511080853360.15288@shark.he.net>
References: <4370AEE1.76F0.0078.0@novell.com> <4370E5C4.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Jan Beulich wrote:

> Pass the trap number causing the call to die() to the die notification
> handler chain.
>
> From: Jan Beulich <jbeulich@novell.com>
>
> (actual patch attached)

I understand that some people need to use attachment for
patches.  In some locations I have that problem myself.

However, the From: in the body above isn't needed.
Or if it's needed, it should be part of the patch.

And the patch (attachment) also contains From:, but it's missing
a Signed-off-by: line.

Please read/study Documentation/SubmittingPatches, esp. the
section on "12) The canonical patch format".


Anyone:  what are acceptable method(s) for using
attachments for patches?

Would no email body be OK?  (I.e., everything in the attachment?)
Everything being "the canonical patch format."

Thanks,
-- 
~Randy
