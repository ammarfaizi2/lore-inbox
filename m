Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUIFWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUIFWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUIFWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 18:18:56 -0400
Received: from rproxy.gmail.com ([64.233.170.199]:13324 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267361AbUIFWSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 18:18:54 -0400
Message-ID: <d577e569040906151832c27358@mail.gmail.com>
Date: Mon, 6 Sep 2004 18:18:47 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: New proposed DRM interface design
Cc: Hamie <hamish@travellingkiwi.com>, Jon Smirl <jonsmirl@gmail.com>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
In-Reply-To: <1094501705.4531.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20040904102914.B13149@infradead.org>
	 <1094386050.1081.33.camel@localhost.localdomain>
	 <9e47339104090508052850b649@mail.gmail.com>
	 <1094398257.1251.25.camel@localhost.localdomain>
	 <9e47339104090514122ca3240a@mail.gmail.com>
	 <1094417612.1936.5.camel@localhost.localdomain>
	 <9e4733910409051511148d74f0@mail.gmail.com>
	 <1094425142.2125.2.camel@localhost.localdomain>
	 <413CCF79.2080407@travellingkiwi.com>
	 <1094501705.4531.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Sep 2004 21:15:07 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> In some cases yes. The DRM is happy with the idea of the kernel being a
> DRM client too.

Thats actually a pretty cool idea. For us that need to use the vesa
fbcon driver because
there is no native driver, it would probably be faster and saner, and
no more problems with
dri drivers that don't play nice with fbcon drivers (is that even an
issue anymore?)

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
