Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261874AbSL2W3C>; Sun, 29 Dec 2002 17:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbSL2W3B>; Sun, 29 Dec 2002 17:29:01 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:41482 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261874AbSL2W3B>; Sun, 29 Dec 2002 17:29:01 -0500
Date: Sun, 29 Dec 2002 22:37:22 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make i2c use initcalls everywhere
Message-ID: <20021229223722.A10670@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"J.A. Magallon" <jamagallon@able.es>, linux-kernel@vger.kernel.org
References: <20021229220436.A11420@lst.de> <20021229222628.GC2259@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021229222628.GC2259@werewolf.able.es>; from jamagallon@able.es on Sun, Dec 29, 2002 at 11:26:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 11:26:28PM +0100, J.A. Magallon wrote:
> Wil this reach the i2c maintainer or the next auto-generated patch from i2c
> 2.8.x will undo what you do now and will be sized 4Gb  ?

There is no maintainer for drivers/i2c/.  The only updates it every got
was me syncinc with their releases and backing out obvious braindamage.

> Will this be accepted if I submit it, even independently of the maintainer ?
> Because I suppose (???) that maintainer is sending changes and they are going
> to trash...

Maybe the changes the maintainers of the external i2c code are sending
_are_ trash?

