Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264023AbTEOO5p (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTEOO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:57:45 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45773 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264023AbTEOO5n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:57:43 -0400
Date: Thu, 15 May 2003 05:52:59 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: bharata@in.ibm.com, Jens Axboe <axboe@suse.de>
cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: Re: 2.5.69-mjb1: undefined reference to `blk_queue_empty'
Message-ID: <233430000.1053003177@[10.10.2.4]>
In-Reply-To: <20030515144643.R31823@in.ibm.com>
References: <9380000.1052624649@[10.10.2.4]> <20030512205139.GT1107@fs.tum.de> <20570000.1052797864@[10.10.2.4]> <20030513124807.A31823@in.ibm.com> <25840000.1052834304@[10.10.2.4]> <20030513181155.GL17033@suse.de> <20030514133843.H31823@in.ibm.com> <20030514083224.GC13456@suse.de> <20030515093731.N31823@in.ibm.com> <20030515072937.GT15261@suse.de> <20030515144643.R31823@in.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Are interrupts already disabled at this point? If yes, then it looks
>> fine.
>> 
> 
> Yes, interrupts are disabled at this point.
> 
> Martin, Could you please take this in, while I push this change to lkcd cvs.

Yup, will add it to next release.
