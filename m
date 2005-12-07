Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbVLGV4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbVLGV4l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030380AbVLGV4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:56:41 -0500
Received: from www.eclis.ch ([144.85.15.72]:44687 "EHLO mail.eclis.ch")
	by vger.kernel.org with ESMTP id S1030379AbVLGV4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:56:40 -0500
Message-ID: <43975A96.9090503@eclis.ch>
Date: Wed, 07 Dec 2005 22:56:38 +0100
From: Jean-Christian de Rivaz <jc@eclis.ch>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: john stultz <johnstul@us.ibm.com>
Cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: ntp problems
References: <200512050031.39438.gene.heskett@verizon.net> <200512061622.54583.gene.heskett@verizon.net> <0E093DF2-A72F-4A76-9BF6-8D7E9B1AF31F@mac.com> <200512070108.58466.gene.heskett@verizon.net>
In-Reply-To: <200512070108.58466.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett a écrit :
> And, acpi is on, and ntpd is happy with the new bios.  Hurrah!

Good news!

I wonder if it would be a good idea to add something into the kernel or 
into ntpd to alert the users that ntpd can't run normaly because of a 
too fast drift ? Then a BIOS upgrade could be proposed (especially on a 
nForce2 system). I don't know if it's even realistc.

Regards,
-- 
Jean-Christian de Rivaz
