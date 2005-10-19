Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbVJSDwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbVJSDwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 23:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932457AbVJSDwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 23:52:08 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51035 "EHLO
	pd5mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932456AbVJSDwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 23:52:06 -0400
Date: Tue, 18 Oct 2005 21:52:23 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ImExPS/2 status
In-reply-to: <4Z9Qz-7an-5@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4355C2F7.1080007@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4Z9Qz-7an-5@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James E. Jennison wrote:
> Hey everyone...this is my first posting here, and I may not be going about 
> this the right way so please forgive me if I am not.  I had a question 
> regarding the status of the code for the ImExPS/2 style mice.
> 
> I currently have a Nexxtech NXX200 PS/2 Optical Wheel Mouse, running kernel 
> 2.6.13.4.  I noticed that prior to the 2.6.x.x series (whilst in the 2.4.x.x 
> series (I was stubborn)), that my mouse was working fine.
> 
> Now, however,if I plug my mouse in, the optical light comes on for perhaps 
> half a second, and the mouse goes dark.  The second thing that happens is if 
> you click either button, or move/click the scrollwheel, the cursor will go to 
> the upper right hand corner of the screen to where you only see a small 
> fraction of it.  This happens in both console mode and in graphical.

Does this also happen if the mouse is plugged in when powering up the 
machine? PS/2 devices are not really designed to be hot-plugged.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

