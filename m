Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRDMSMQ>; Fri, 13 Apr 2001 14:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131563AbRDMSMG>; Fri, 13 Apr 2001 14:12:06 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:37803 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S131562AbRDMSL5>; Fri, 13 Apr 2001 14:11:57 -0400
Message-ID: <3AD7416A.A6B65A86@bigfoot.com>
Date: Fri, 13 Apr 2001 11:11:54 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19pre17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SW-RAID0 Performance problems
In-Reply-To: <Pine.LNX.4.10.10104131048550.1669-100000@coffee.psychology.mcmaster.ca> <01041317365500.00665@debian> <20010413090751.E4557@greenhydrant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> What happens if your run hdparm -t /dev/hda and /dev/hdc at the same time?

Try 'hdparm -tT'  with simultaneous /dev/hda3 and /dev/hdc3.  This gives you
a baseline on the actual partitions involved.

rgds,
tim.
--
