Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbTHVVjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 17:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbTHVVjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 17:39:40 -0400
Received: from mrout2.yahoo.com ([216.145.54.172]:55560 "EHLO mrout2.yahoo.com")
	by vger.kernel.org with ESMTP id S261714AbTHVVjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 17:39:39 -0400
Message-ID: <3F468D91.3040806@bigfoot.com>
Date: Fri, 22 Aug 2003 14:39:29 -0700
From: Erik Steffl <steffl@bigfoot.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i386; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Intel 865 AGP and nVidia driver problem
References: <20030822210555.GX1437@inxservices.com>
In-Reply-To: <20030822210555.GX1437@inxservices.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Garvey wrote:
>    Just bought a new computer, Intel D865PERL motherboard, one P4 SMP
> w/HT. When starting X in both 2.6.0-test3 and 2.4.22-rc2 with pre7-aa1,
> screen goes black and system is gone (fortunately system keys to unmount
> and reboot work). Last line in X log shows MMIO registers, but could
> have gotten further and just not on disk.

   I have:

     - same MB Intel D865PERL
     - Nvidia FX 5600 Ultra (by PNY), AGP
     - kernel 2.4.21 (ac4)
     - XFree86 4.2.1.1 (on debian unstable)

   and:

     - proprietary nvidia driver works
     - XFree86 vesa driver works

	erik

