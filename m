Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVBVGma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVBVGma (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 01:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbVBVGma
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 01:42:30 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:34490 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262220AbVBVGmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 01:42:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=IAknri463ST+x5ECP8joBa0Pql2B/e0/Ggh4RmfuL0TiC9QsY0RBCo5zBWw+yizlb/x31I4xSpRhr2AX4OYOf230AptmvKid89noZsii+dXSF8INAfyFaDybLKsFn66MZFjMZSaI1Hqh63eOhCQVQQcM0RYXJoS+9gg7Pk+jQHU=
Message-ID: <9e473391050221224269186140@mail.gmail.com>
Date: Tue, 22 Feb 2005 01:42:23 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: POSTing of video cards (WAS: Solo Xgl..)
Cc: Alex Deucher <alexdeucher@gmail.com>, Dave Airlie <airlied@linux.ie>,
       dri-devel@lists.sourceforge.net,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       xorg@lists.freedesktop.org
In-Reply-To: <1109053960.5326.91.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0502201049480.18753@skynet>
	 <1108973275.5326.8.camel@gaston>
	 <9e47339105022111082b2023c2@mail.gmail.com>
	 <1109019855.5327.28.camel@gaston>
	 <9e4733910502211717116a4df3@mail.gmail.com>
	 <1109041968.5412.63.camel@gaston>
	 <a728f9f9050221205634a3acf0@mail.gmail.com>
	 <1109049217.5412.79.camel@gaston>
	 <9e4733910502212203671eec73@mail.gmail.com>
	 <1109053960.5326.91.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2005 17:32:40 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> And even if we did, then we could have the vga "legacy" driver use the
> firmware loader to "boot" them. And again, you seem to dismiss all my
> other arguments...

I'm not dismissing them, I'm in agreement with with doing it in the
drivers if we are sure we have thought through all of the different
cases where we might need to post.

-- 
Jon Smirl
jonsmirl@gmail.com
