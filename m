Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131843AbQKAXZS>; Wed, 1 Nov 2000 18:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131854AbQKAXZJ>; Wed, 1 Nov 2000 18:25:09 -0500
Received: from hybrid-024-221-152-185.az.sprintbbd.net ([24.221.152.185]:48628
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S131843AbQKAXYy>; Wed, 1 Nov 2000 18:24:54 -0500
Date: Wed, 1 Nov 2000 16:21:08 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: garloff@suse.de, jamagallon@able.es, linux-kernel@vger.kernel.org
Subject: Re: Where did kgcc go in 2.4.0-test10 ?
Message-ID: <20001101162108.C32641@opus.bloom.county>
In-Reply-To: <20001101234058.B1598@werewolf.able.es> <20001101235734.D10585@garloff.etpnet.phys.tue.nl> <200011012247.OAA19546@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011012247.OAA19546@pizda.ninka.net>; from davem@redhat.com on Wed, Nov 01, 2000 at 02:47:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2000 at 02:47:21PM -0800, David S. Miller wrote:
>    Date: 	Wed, 1 Nov 2000 23:57:34 +0100
>    From: Kurt Garloff <garloff@suse.de>
> 
>    kgcc is a redhat'ism.
> 
> Debian has it too.

Yes, but what's more important is that all of these "kgcc" variants are
gcc 2.7.2.x-based (unless there's one I don't know about).  And we don't want
2.7.2.x, we want egcs 1.1.2 or newer (but not gcc 2.9x, unless you know what
you're doing and are trying to fix the compiler. :)).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
