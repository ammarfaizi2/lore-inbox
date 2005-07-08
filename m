Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVGHQLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVGHQLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 12:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVGHQLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 12:11:30 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:53221 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262694AbVGHQL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 12:11:29 -0400
Message-ID: <42CEA5E4.40009@gentoo.org>
Date: Fri, 08 Jul 2005 17:12:20 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050403)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick McHardy <kaber@trash.net>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org
Subject: Re: 2.6.12 netfilter: local packets marked as invalid
References: <42CE86B5.2080705@gentoo.org> <42CE8E96.1040905@trash.net>
In-Reply-To: <42CE8E96.1040905@trash.net>
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy wrote:
> You could confirm this theory by logging invalid packets in LOCAL_OUT
> and in PRE_ROUTING - only PRE_ROUTING should trigger. I'm going to
> think about a solution meanwhile.

You'll have to forgive my lack of netfilter knowledge, I set up my firewall
ages ago and haven't really touched it since :)

How can I do this with iptables?

Thanks,
Daniel
