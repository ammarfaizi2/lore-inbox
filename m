Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUG1XIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUG1XIj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267184AbUG1XHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:07:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62100 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S267317AbUG1XGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:06:36 -0400
Date: Wed, 28 Jul 2004 16:06:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] fix zlib debug in ppc boot header
Message-ID: <20040728230635.GC16468@smtp.west.cox.net>
References: <20040728112222.GA7670@suse.de> <1091014495.2795.25.camel@laptop.fenrus.com> <20040728150145.GK10891@smtp.west.cox.net> <20040728153633.GA21105@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728153633.GA21105@suse.de>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 05:36:33PM +0200, Olaf Hering wrote:

> 
>  On Wed, Jul 28, Tom Rini wrote:
> 
> > Olaf, has having this code work for you ever been useful?  Thanks.
> 
> The debug stuff? Sure. Now I know we have to improve the memcpy
> alignment handling. But thats a different story.

Can you please elaborate?  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
