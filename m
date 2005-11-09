Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbVKIRGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbVKIRGW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 12:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVKIRGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 12:06:22 -0500
Received: from xenotime.net ([66.160.160.81]:57816 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750936AbVKIRGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 12:06:21 -0500
Date: Wed, 9 Nov 2005 09:06:16 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jeff Garzik <jgarzik@pobox.com>
cc: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
In-Reply-To: <43722AFC.4040709@pobox.com>
Message-ID: <Pine.LNX.4.58.0511090904320.4001@shark.he.net>
References: <43720DAE.76F0.0078.0@novell.com> <43722AFC.4040709@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, Jeff Garzik wrote:

> Jan Beulich wrote:
> > The following patch set represents the Novell Linux Kernel Debugger,
> > stripped off of its original low-level exception handling framework.
>
>
> Honestly, just seeing all these code changes makes me think we really
> don't need it in the kernel.  How many "early" and "alternative" gadgets
> do we really need just for this thing?

On the surface I have to agree.  However, if Jan wants feedback
on the patches, that's a reasonable request IMO.
(but they need to be readable via email so that someone
can comment on them)

At a quick blush, I would guess it has as much chance as
kdb does (or did) for merging.

-- 
~Randy
