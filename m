Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271474AbTGQOuA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 10:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271476AbTGQOt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 10:49:59 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:2012 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S271474AbTGQOtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 10:49:55 -0400
Message-ID: <3F1668FF.8060206@cornell.edu>
Date: Thu, 17 Jul 2003 05:14:39 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J. Hidding" <J.Hidding@student.rug.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.0-test1 freezes sometimes
References: <web-8156551@mail.rug.nl>
In-Reply-To: <web-8156551@mail.rug.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experience freezes too, with recent 2.5 kernels, as well as i/o 
lockups (attempted disk activity freezes programs, but I can move the 
mouse, etc...). I posted an oops (kernel BUG) for the second here:

http://www.ussg.iu.edu/hypermail/linux/kernel/0307.1/1682.html

Are you using tcq by any chance? Just curious.



