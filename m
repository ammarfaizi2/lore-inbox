Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261183AbTIRNha (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTIRNha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:37:30 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:59370 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261183AbTIRNh3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:37:29 -0400
Message-ID: <3F69B517.8080903@genebrew.com>
Date: Thu, 18 Sep 2003 09:37:27 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030908 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: koala.gnu@tiscali.it
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: cpu speed
References: <3F697B67.8070409@tiscali.it>
In-Reply-To: <3F697B67.8070409@tiscali.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.152.250.151] at Thu, 18 Sep 2003 08:37:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Koala GNU wrote:
> Hi all,
> 
> I have a T21 thinkpad Pentium III 800 MHz.
> 
> I have redhat 8.0 with linux 2.4.18 installed on my machine.
> 
> Executing cat /proc/cpuinfo I noticed that cpu speed is 200 MHz.
> 
> Looking at BIOS the speed is correct.

Does this happen irrespective of whether you are plugged in to A/C power 
at the time? Most laptops will go to lower speeds on battery (depending 
on your setup in BIOS), and even if you plug in the power later, 
/proc/cpuinfo is not updated. So please make sure you boot up with A/C 
power and let us know if you see the same thing.

Thanks,
Rahul
--
Rahul Karnik
rahul@genebrew.com
http://www.genebrew.com/

