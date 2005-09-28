Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVI1Aol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVI1Aol (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVI1Aol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:44:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:54120 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965238AbVI1Aok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:44:40 -0400
Date: Tue, 27 Sep 2005 18:45:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Strange behaviour with SATA disks. Light always ON
In-reply-to: <4RuIM-7uQ-39@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4339E7A9.5000104@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-15
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4QSjW-N8-7@gated-at.bofh.it> <4QSjW-N8-5@gated-at.bofh.it>
 <4RuIM-7uQ-39@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo da Silva wrote:
> BTW, the kernel configuration has a specific "option" for
> Silicon Image SATA, but if I choose it without "ahci"
> the system does not boot! Why?

Because it appears your system has both controllers, and all the drives 
are connected to the AHCI controller?

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

