Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUFRSe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUFRSe1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUFRSbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:31:07 -0400
Received: from pop.gmx.net ([213.165.64.20]:42404 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266640AbUFRS1D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:27:03 -0400
X-Authenticated: #20450766
Date: Fri, 18 Jun 2004 20:21:15 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Martin Hermanowski <martin@mh57.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: space left on ext3 (2.6.6-bk3)
In-Reply-To: <20040617223729.GA2654@mh57.de>
Message-ID: <Pine.LNX.4.60.0406182018040.7426@poirot.grange>
References: <Pine.LNX.4.60.0406180018530.9599@poirot.grange>
 <20040617223729.GA2654@mh57.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, Martin Hermanowski wrote:

> On Fri, Jun 18, 2004 at 12:23:25AM +0200, Guennadi Liakhovetski wrote:
>
> I think you have 5% reserved for root, as this is the default setting
> when creating ext3 fs'.

Oh, I forgot about that again... Wouldn't it be good to have df either
1) report different amounts for root / non-root
or
2) report both
?

Thanks
Guennadi
---
Guennadi Liakhovetski

