Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbVKHRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbVKHRNd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 12:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbVKHRNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 12:13:33 -0500
Received: from xenotime.net ([66.160.160.81]:53457 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030273AbVKHRNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 12:13:32 -0500
Date: Tue, 8 Nov 2005 09:13:28 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Jan Beulich <JBeulich@novell.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: make trap information available to die handlers
In-Reply-To: <4370E9A2.76F0.0078.0@novell.com>
Message-ID: <Pine.LNX.4.58.0511080912090.15288@shark.he.net>
References: <4370AEE1.76F0.0078.0@novell.com>  <4370E5C4.76F0.0078.0@novell.com>
 <Pine.LNX.4.58.0511080853360.15288@shark.he.net> <4370E9A2.76F0.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2005, Jan Beulich wrote:

> >And the patch (attachment) also contains From:, but it's missing
> >a Signed-off-by: line.
>
> I looked at many ChangeLog entries (which supposedly get created from
> the abstract), and by far not all of them have the author listed both as
> From: and Singed-Off-By:, which made me think that either of the two
> should be sufficient (and I really can't see why the author information
> needs to appear twice).

Tools can determined the From: part from your email, so it's
often safe to omit that part.

The S-o-b part is required...

-- 
~Randy
