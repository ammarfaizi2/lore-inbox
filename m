Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262463AbVAPIxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262463AbVAPIxS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 03:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbVAPIxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 03:53:18 -0500
Received: from ip18.tpack.net ([213.173.228.18]:32272 "HELO mail.tpack.net")
	by vger.kernel.org with SMTP id S262463AbVAPIxQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 03:53:16 -0500
Message-ID: <41EA2BE5.6080906@tpack.net>
Date: Sun, 16 Jan 2005 09:55:01 +0100
From: Tommy Christensen <tommy.christensen@tpack.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmorris@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: fixes in audit_log_drain()
References: <41E9A25E.3010902@tpack.net>
In-Reply-To: <41E9A25E.3010902@tpack.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Christensen wrote:
> o Don't send shared skb's to netlink_unicast

Never mind. Herbert Xu made a better fix for this in netlink.

-Tommy
