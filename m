Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbTJJTer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263145AbTJJTer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:34:47 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:19465 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263144AbTJJTeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:34:46 -0400
Date: Fri, 10 Oct 2003 20:34:34 +0100
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
Message-ID: <20031010193434.GJ25856@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1065784536.2071.3.camel@paragon.slim> <20031010184241.GC32600@redhat.com> <1065813288.1861.4.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065813288.1861.4.camel@paragon.slim>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 09:14:48PM +0200, Jurgen Kramer wrote:
 > Some more details. Although this is an 800MHz CPU
 > /sys/devices/system/cpu/cpu0/cpufreq gives:
 > 
 > [root@paradox cpufreq]# more *
 > ::::::::::::::
 > cpuinfo_max_freq
 > ::::::::::::::
 > 995

wtf, it still displays "Highestspeed=798MHz" on startup though right ?

		Dave
 
-- 
 Dave Jones     http://www.codemonkey.org.uk
