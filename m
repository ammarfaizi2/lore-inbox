Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTJYV5O (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 17:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263110AbTJYV5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 17:57:13 -0400
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:23609 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S263060AbTJYV5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 17:57:11 -0400
Message-ID: <3F9AF1AB.3000304@planet.nl>
Date: Sat, 25 Oct 2003 23:56:59 +0200
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Heavy disk activity without apperant reason
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On my AMD athlon system with 512MB memory I sometimes get a lot of disk 
activity the activity normaly lasts for about 10 seconds and after that 
the disk stays relativily quiet as expected with the load on the system. 
When I look into top I don't see any programs that could explain the 
disk activity. The system is in most cases not using any swap.

The system configuration is as following.

AMS athlon 1400
512MB main mem
18GB scsi disk 10K
29160 adaptec scsi controller
using a via kt2666 chipset

I'm not sure if I should log a bug and what the problem area could be.

Thanks in advance for helping out,

Stef

