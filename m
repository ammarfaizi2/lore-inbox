Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280599AbRKNOVQ>; Wed, 14 Nov 2001 09:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280600AbRKNOVH>; Wed, 14 Nov 2001 09:21:07 -0500
Received: from t2.redhat.com ([199.183.24.243]:65262 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S280599AbRKNOUx>; Wed, 14 Nov 2001 09:20:53 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011114135540.A513@markcomp.blaydon.hymers.org.uk> 
In-Reply-To: <20011114135540.A513@markcomp.blaydon.hymers.org.uk>  <20011114011018.A981@markcomp.blaydon.hymers.org.uk> 
To: Mark Hymers <markh@linuxfromscratch.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        chaffee@cs.berkeley.edu
Subject: Re: MODULE_LICENSE tags for nls 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 14 Nov 2001 14:20:46 +0000
Message-ID: <25977.1005747646@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


markh@linuxfromscratch.org said:
>  By the way, should patches sent to LKML and the (probable) maintainer
> be CC'd to Linus and Alan?

If the code you're patching is actively maintained, then no - don't Cc Linus
and Alan on the first attempt. This gives the maintainer a chance to provide
a better patch, argue that no patch is required, or merge it with other
changes which are pending. 

If the maintainer ignores you and you have to resend your patch, include
Linus and/or Alan on the second (and subsequent) attempts.

For code which isn't actively maintained, it's more acceptable to include
Linus and/or Alan on the first attempt. 

--
dwmw2


