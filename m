Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261689AbVBSJFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbVBSJFy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 04:05:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVBSJF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 04:05:29 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:31149 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261681AbVBSJAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 04:00:25 -0500
Subject: Re: Should kirqd work on HT?
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: kwijibo@zianet.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4216E043.1060507@zianet.com>
References: <1108794699.4098.28.camel@desktop.cunningham.myip.net.au>
	 <4216E043.1060507@zianet.com>
Content-Type: text/plain
Message-Id: <1108803727.4098.31.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 19 Feb 2005 20:02:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2005-02-19 at 17:44, Kwijibo wrote:
> My guess is that irqbalance is not running.

No. It is.

USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
root       301  0.0  0.0     0    0 ?        SW   16:52   0:00 [kirqd]

The debugging info reports that it doesn't think it's worth doing the
balancing.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

