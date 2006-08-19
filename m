Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751757AbWHSOxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbWHSOxk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbWHSOxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 10:53:40 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43024 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751757AbWHSOxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 10:53:40 -0400
Date: Sat, 19 Aug 2006 16:53:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Kun Niu <haoniukun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How can I enable NET_WIRELESS?
Message-ID: <20060819145339.GI7813@stusta.de>
References: <ec9e7ff10608190540o5ac666bau1451d43e69e66417@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec9e7ff10608190540o5ac666bau1451d43e69e66417@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 19, 2006 at 08:40:50PM +0800, Kun Niu wrote:
> Dear all,
> 
> I'm sorry for the silly questoin.
> My kernel version is 2.6.17
> But I've just installed the 802.11 stack on my Debian 3.1.
> But I got that the module can't find some external module:
> WARNING: 
> /lib/modules/2.6.17-5/kernel/net/ieee80211/softmac/ieee80211softmac.ko
> needs unknown symbol wireless_send_event
> WARNING: /lib/modules/2.6.17-5/kernel/net/ieee80211/ieee80211.ko needs
> unknown symbol wireless_spy_update
> And I think that I'll have to install the NET_WIRELESS module.
> But I can't find it.
> When I look for wireless in menuconfig of the kernel, I found that
> NET_WIRELESS=n.
> 
> Would anyone be kind enough telling how to enable NET_WIRELESS?

Please send your .config .

> Thanks in advance.

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

