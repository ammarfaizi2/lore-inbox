Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751355AbVJXW3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbVJXW3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbVJXW3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:29:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:30456 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751357AbVJXW3p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:29:45 -0400
Message-ID: <435D6017.8090001@mvista.com>
Date: Mon, 24 Oct 2005 15:28:39 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix Oxley <lkml@oxley.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: [ANNOUNCE] 2.6.14-rc5-rt5 kgdb update
References: <20051017160536.GA2107@elte.hu> <200510211118.18363.lkml@oxley.org> <200510211126.38200.lkml@oxley.org> <200510230023.41494.lkml@oxley.org>
In-Reply-To: <200510230023.41494.lkml@oxley.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For those using kgdb on the rt kernel, I have just updated the patches at:
http://source.mvista.com/~ganzinger/
-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
