Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWFXVlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWFXVlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 17:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbWFXVlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 17:41:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14309 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751109AbWFXVlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 17:41:46 -0400
Date: Sat, 24 Jun 2006 14:41:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Airlie <airlied@linux.ie>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [git pull] DRM driver updates
In-Reply-To: <Pine.LNX.4.64.0606240851530.30220@skynet.skynet.ie>
Message-ID: <Pine.LNX.4.64.0606241439510.6483@g5.osdl.org>
References: <Pine.LNX.4.64.0606240851530.30220@skynet.skynet.ie>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Jun 2006, Dave Airlie wrote:
> 
> commit c499aeb08cb24bed60e5bfc80720597bcf1a720d
> Author: Dave Airlie <airlied@linux.ie>
> Date:   Sat Jun 24 17:37:48 2006 +1000
> 
>     drm: radeon constify radeon microcode
> 
>     From: Tilman (DRM CVS)
>     Signed-off-by: Dave Airlie <airlied@linux.ie>

Your commits have the authorship information, but it's in a bad format, 
and whatever tools you've used to turn them into git don't turn it into 
git authorship.

Please please fix.

And doggone, if you're really using CVS for DRM maintenance, hit somebody 
with a clue-stick already ;)

		Linus
