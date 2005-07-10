Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVGJW2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVGJW2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 18:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGJW1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 18:27:22 -0400
Received: from mail.dvmed.net ([216.237.124.58]:33462 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262161AbVGJWZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 18:25:09 -0400
Message-ID: <42D1A039.9090807@pobox.com>
Date: Sun, 10 Jul 2005 18:24:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: olh@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/82] changing CONFIG_LOCALVERSION rebuilds too much,
 for no good reason.
References: <20050710193508.0.PmFpst2252.2247.olh@nectarine.suse.de> <20050710.144910.15269860.davem@davemloft.net>
In-Reply-To: <20050710.144910.15269860.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> Kernel janitor-like patches split up their work _FAR_ too much.  They
> post one patch per driver, or even per-file, for something as simple
> as removing the use of a redundant header file.  That's totally
> rediculious, and bloats up the kernel changelog history for no good
> reason.  Instead, you should just post one big patch for all of
> drivers/, one for all of net/, something like that.


Whoops, in an email just sent, I repeated what you said here, except 
that you said it better :)

100% agreed...

	Jeff


