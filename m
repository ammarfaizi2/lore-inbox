Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262959AbVCXApV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262959AbVCXApV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbVCXApV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:45:21 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:30372 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262959AbVCXAnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:43:17 -0500
Date: Thu, 24 Mar 2005 00:43:16 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Andrew Morton <akpm@osdl.org>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] verify_area to access_ok conversion in
 drivers/char/drm/drm_os_linux.h
In-Reply-To: <Pine.LNX.4.62.0503240021330.7460@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.58.0503240042200.17798@skynet>
References: <Pine.LNX.4.62.0503240021330.7460@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> verify_area is deprecated, replaced by access_ok.
> Seems I missed this one when I did the big overall conversion.
>
>
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
>

In my tree for 2.6.12.. just have to fix the big clangers first..

Dave.
