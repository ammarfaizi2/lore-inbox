Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266028AbUFVVRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266028AbUFVVRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 17:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266072AbUFVVPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 17:15:55 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:47778 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265930AbUFVVNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 17:13:37 -0400
Message-ID: <40D8A122.7020806@hotmail.com>
Date: Tue, 22 Jun 2004 14:14:10 -0700
From: walt <wa1ter@hotmail.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040622
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.7-bk] NFS-related kernel panic
References: <fa.l7nhc0k.1k1oepm@ifi.uio.no> <fa.gh5h9hv.b2sm3v@ifi.uio.no>
In-Reply-To: <fa.gh5h9hv.b2sm3v@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

> The lockless loopback transmission patch mucks up the preempt count.
> Can you give this patch a try?

I saw an update to loopback.c from linus which I assume was yours --
anyway my panic is fixed.  Thanks.

