Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVBANS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVBANS4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 08:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262016AbVBANS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 08:18:56 -0500
Received: from [62.206.217.67] ([62.206.217.67]:29654 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262014AbVBANSw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 08:18:52 -0500
Message-ID: <41FF81BA.5020208@trash.net>
Date: Tue, 01 Feb 2005 14:18:50 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tompa Septimius Paul <subzero@cj.onrc.ro>
CC: linux-kernel@vger.kernel.org, netfilter@lists.netfilter.org
Subject: Re: iptables and ip_conntrack_tuple.h compile fix
References: <Pine.LNX.4.58.0502011255020.24684@cj.onrc.ro>
In-Reply-To: <Pine.LNX.4.58.0502011255020.24684@cj.onrc.ro>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tompa Septimius Paul wrote:

>Hi,
>
>I try to recompile iptables iptables-1.2.11 with kernel 2.6.11-rc2
>(and mm2) running and I don't succeed. It complains about
>/usr/src/linux/include/linux/netfilter_ipv4/ip_conntrack_tuple.h
>after this small changes iptables is compiling again.
>  
>
I just added a similar patch from Pablo Neira to my tree.

Regards
Patrick

