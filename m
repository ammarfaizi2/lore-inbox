Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTDXItE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 04:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbTDXItD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 04:49:03 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27829 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261903AbTDXItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 04:49:01 -0400
Date: Thu, 24 Apr 2003 09:00:51 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Bernhard Kaindl <bernhard.kaindl@gmx.de>,
       Yusuf Wilajati Purna <purna@sm.sony.co.jp>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org, arjanv@redhat.com,
       Bernhard Kaindl <bk@suse.de>
Subject: Re: [PATCH][2.4+ptrace] fix side effects of the kmod/ptrace secfix
Message-ID: <20030424090051.D24363@devserv.devel.redhat.com>
References: <3E9E3FA9.6060509@sm.sony.co.jp> <Pine.LNX.4.53.0304190532520.1887@hase.a11.local> <3EA4CD3F.9040902@sm.sony.co.jp> <Pine.LNX.4.53.0304222236040.2341@hase.a11.local> <3EA778E7.5040903@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EA778E7.5040903@vgertech.com>; from nuno.silva@vgertech.com on Thu, Apr 24, 2003 at 06:40:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 06:40:55AM +0100, Nuno Silva wrote:
> Good morning! :)
> 
> I'd like to ear an "official" word on this subject, please. :)
> Is this patch still secure?

The check is loosend too much.
