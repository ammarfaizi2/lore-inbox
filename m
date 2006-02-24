Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWBXHce@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWBXHce (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 02:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWBXHce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 02:32:34 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8676 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750832AbWBXHcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 02:32:33 -0500
Date: Fri, 24 Feb 2006 08:32:30 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Asfand Yar Qazi <ay0106@qazi.f2s.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 'vga=' parameter wierdness
In-Reply-To: <43FC574A.4000100@qazi.f2s.com>
Message-ID: <Pine.LNX.4.61.0602240832150.16363@yvahk01.tjqt.qr>
References: <43FC1624.8090607@qazi.f2s.com> <200602221130.13872.vda@ilport.com.ua>
 <43FC54B8.7070706@qazi.f2s.com> <mj+md-20060222.121130.6225.albireo@ucw.cz>
 <43FC574A.4000100@qazi.f2s.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > OK, will try that.  decimal of octal(0164) = decimal(116)
>> 
>> This won't work -- the mode numbers are hexadecimal, not octal.
>> Use 356 (decimal).
>
> You're right.  I thought '0164' was octal - 0 prefix.
>
Quite misleading. This should be fixed.


Jan Engelhardt
-- 
