Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265800AbTIFKIZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 06:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbTIFKIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 06:08:25 -0400
Received: from johanna5.ux.his.no ([152.94.1.25]:47856 "EHLO
	johanna5.ux.his.no") by vger.kernel.org with ESMTP id S265800AbTIFKIY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 06:08:24 -0400
Date: Sat, 6 Sep 2003 12:08:18 +0200
From: Erlend Aasland <erlend-a@ux.his.no>
To: "David S. Miller" <davem@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CRYPTO] add alg. type to /proc/crypto output
Message-ID: <20030906100818.GA24931@johanna5.ux.his.no>
References: <20030905143859.GA18143@johanna5.ux.his.no> <20030905073403.0b939b0a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905073403.0b939b0a.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/03 07:34, David S. Miller wrote:
> Is it even useful?
Check http://samba.org/~jamesm/crypto/TODO
It's listed under medium priority, so I thought I was doing a good
thing implementing it.

> 
> When you see names like "md5" and parameters such as "digestsize"
> listed, do you really have no clue that it is a "digest"?  :-)
Good point.
