Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161078AbWHDHS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWHDHS7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 03:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161079AbWHDHS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 03:18:59 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:14752 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1161078AbWHDHS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 03:18:58 -0400
From: Grant Coady <gcoady.lk@gmail.com>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [patch 00/23] -stable review
Date: Fri, 04 Aug 2006 17:18:44 +1000
Organization: http://bugsplatter.mine.nu/
Reply-To: Grant Coady <gcoady.lk@gmail.com>
Message-ID: <als5d2poja909k80kb5c2e2e6cuhboou7v@4ax.com>
References: <20060804053807.GA769@kroah.com>
In-Reply-To: <20060804053807.GA769@kroah.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006 22:38:07 -0700, Greg KH <gregkh@suse.de> wrote:

>This is the start of the stable review cycle for the 2.6.17.8 release.
>There are 23 patches in this series, all will be posted as a response to
>this one.  If anyone has any issues with these being applied, please let
>us know.  If anyone is a maintainer of the proper subsystem, and wants
>to add a Signed-off-by: line to the patch, please respond with it.
>
>These patches are sent out with a number of different people on the Cc:
>line.  If you wish to be a reviewer, please email stable@kernel.org to
>add your name to the list.  If you want to be off the reviewer list,
>also email us.
>
>Responses should be made by Sunday, August 6, 05:00:00 UTC.  Anything
>received after that time might be too late.
>
>I've also posted a roll-up patch with all changes in it if people want
>to test it out.  It can be found at:
>
>	kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.17.8-rc1.gz

It wasn't clear that this is a delta 2.6.17.7 -> 2.6.17.8 patch ;)

Didn't bump version:
grant@sempro:~/linux/linux-2.6.17.8-rc1$ head -5 Makefile
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 17
EXTRAVERSION = .7
NAME=Crazed Snow-Weasel

On the bright side, it compiled and runs ;)

Grant.
