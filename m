Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbUEADxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUEADxx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUEADxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:53:53 -0400
Received: from smtp05.web.de ([217.72.192.209]:30686 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S261925AbUEADxw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:53:52 -0400
Message-ID: <40931F54.8020908@web.de>
Date: Sat, 01 May 2004 05:53:56 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: libata + siI3112 + 2.6.5-rc3 hang
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 > Didn't work. Still hangs rather well. :/

And if you disable APIC with "noapic" or also "nolapic". I had it with 2 
nForce2 boards. An MSI and now Abit NF7-S. No one runs stable with APIC 
enabled.

Marcus

