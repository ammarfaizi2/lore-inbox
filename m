Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262462AbUD2S6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUD2S6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 14:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUD2S6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 14:58:55 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:57803 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S262462AbUD2S6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 14:58:53 -0400
Message-ID: <40915265.2050906@am.sony.com>
Date: Thu, 29 Apr 2004 12:07:17 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
CC: linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org,
       linux-sh-ctl@m17n.org,
       CE Linux Developers List <celinux-dev@tree.celinuxforum.org>
Subject: CONFIG_XIP_ROM vs. CONFIG_XIP_KERNEL
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at some sources for kernel Execute-in-place (XIP).

I see references to CONFIG_XIP_ROM and CONFIG_XIP_KERNEL,
in different architecture branches of the same kernel
source tree.

Is this difference merely the result of inconsistent
usage, or is there a functional difference between
these two options?

I can imagine that CONFIG_XIP_ROM is intended only to
handle XIP in ROM, and that CONFIG_XIP_KERNEL possibly
handles additional cases like XIP in flash.  However,
before jumping to that conclusion I thought I would
ask if there is some intention behind the different
config names.

Thanks,

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird (at) am.sony.com
=============================


