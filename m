Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266039AbUALDw4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 22:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbUALDw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 22:52:56 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:15367 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S266039AbUALDwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 22:52:55 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: linux-2.4.24 released
Date: Sun, 11 Jan 2004 22:54:26 -0500
Organization: TMR Associates, Inc
Message-ID: <btt4vs$3di$1@gatekeeper.tmr.com>
References: <200401051355.i05DtvgC020415@hera.kernel.org> <1073321792.21338.2.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-Trace: gatekeeper.tmr.com 1073878845 3506 192.168.12.10 (12 Jan 2004 03:40:45 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <1073321792.21338.2.camel@midux>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:
> make modules_install fails with the following errors:
> 
> depmod: *** Unresolved symbols in
> /lib/modules/2.4.24/kernel/drivers/net/dummy.o
> depmod:         dev_alloc_name_R96db38a6
> depmod:         kmalloc_R93d4cfe6
> depmod:         ether_setup_R0309250f
> depmod:         unregister_netdev_Rbe3cfced
> depmod:         kfree_R037a0cba
> depmod:         __kfree_skb_R934b4bff
> depmod:         register_netdev_R7378c15b

Sounds like obsolete modutils... Just a guess

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
