Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265448AbSJSBec>; Fri, 18 Oct 2002 21:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265452AbSJSBec>; Fri, 18 Oct 2002 21:34:32 -0400
Received: from bitchcake.off.net ([216.138.242.5]:41195 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S265448AbSJSBea>;
	Fri, 18 Oct 2002 21:34:30 -0400
Date: Fri, 18 Oct 2002 21:40:31 -0400
From: Zach Brown <zab@zabbo.net>
To: "David S. Miller" <davem@redhat.com>
Cc: sandy@storm.ca, mk@linux-ipv6.org, linux-kernel@vger.kernel.org,
       design@lists.freeswan.org, usagi@linux-ipv6.org
Subject: Re: [Design] [PATCH] USAGI IPsec
Message-ID: <20021018214031.D22727@bitchcake.off.net>
References: <m3k7kpjt7c.wl@karaba.org> <3DA857AB.2010504@storm.ca> <20021011.192750.85684324.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021011.192750.85684324.davem@redhat.com>; from davem@redhat.com on Fri, Oct 11, 2002 at 07:27:50PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's fine for testing purposes, leave it in.

absolutely.  it could also be needed for interoperability, or many other
valid uses that might not depend on its sheer strength as a cipher.

"but you shouldn't be interoperating with things that are insecure!"

blah blah blah.  that is not the kernel's decision to make.  meaningful
security is defined by much more than context-free assertions.  warn
against its naive use, avoid it being a default, but allow the clued to
use it easily when it makes sense.

- z
