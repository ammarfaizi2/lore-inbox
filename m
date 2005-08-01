Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262161AbVHAHYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbVHAHYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 03:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVHAHYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 03:24:22 -0400
Received: from main.gmane.org ([80.91.229.2]:63897 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262161AbVHAHXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 03:23:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Stefan Seyfried <seife@suse.de>
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Date: Mon, 01 Aug 2005 08:19:42 +0200
Message-ID: <dckikj$e8$1@sea.gmane.org>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>	 <1122678943.9381.44.camel@mindpipe>	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>	 <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz>	 <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz>	 <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz>	 <42ED4CCF.6020803@andrew.cmu.edu>  <20050731224752.GC27580@elf.ucw.cz> <1122852234.13000.27.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: charybdis-ext.suse.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050715 Thunderbird/1.0.6 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en
In-Reply-To: <1122852234.13000.27.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-08-01 at 00:47 +0200, Pavel Machek wrote:
>> I'm pretty sure at least one distro will go with HZ<300 real soon now
>> ;-).
>> 
> 
> Any idea what their official recommendation for people running apps that
> require the 1ms sleep resolution is?  Something along the lines of "Get
> bent"?

MPlayer is using /dev/rtc and was running smooth for me since the good
old 2.4 days.
-- 
Stefan Seyfried

