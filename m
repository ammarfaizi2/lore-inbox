Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261748AbUKIWql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUKIWql (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 17:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKIWqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 17:46:40 -0500
Received: from smtp1.jazztel.es ([62.14.3.161]:34193 "EHLO smtp1.jazztel.es")
	by vger.kernel.org with ESMTP id S261748AbUKIWp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 17:45:59 -0500
Message-ID: <41914889.7060308@wanadoo.es>
Date: Tue, 09 Nov 2004 23:45:29 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.4.3) Gecko/20041005
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: [PATCH 2.6-bk 1/1] tg3: add license
References: <4190A32E.6090200@wanadoo.es> <20041109124704.1f8cb3ad.davem@redhat.com>
In-Reply-To: <20041109124704.1f8cb3ad.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

> Why add this, it's basically implied?

Maybe it should be answered by a lawyer,
but it's better to protect our freedom because
law is very 'variable'.

> We have a copy of the file "COPYING" at the top
> of the source tree, which is why we don't duplicate
> it's contents nor excerpts all over the tree.

This is not a duplicate, it's only an advertisement.

Long time ago Torvalds wrote at COPYING:
"[...]
Also note that the only valid version of the GPL as far as the kernel
is concerned is _this_ particular version of the license (ie v2, not
v2.2 or v3.x or whatever), unless explicitly otherwise stated.
[...]"

what does MODULE_LICENSE("GPL") mean at tg3.c ?

GPL 1.0 ?

GPL 2 ?

any GPL ?

only 'GPL' ?


Is possible to write BSD or BSD/GPL or GPLv2 or GPL drivers/code
*inside* Linux kernel ?

--
TLOZ OOT: worse than drugs.


