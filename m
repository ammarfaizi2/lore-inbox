Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262344AbULOMts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbULOMts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 07:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbULOMts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 07:49:48 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:6920 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262344AbULOMtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 07:49:47 -0500
Message-ID: <41C032E5.3060404@stud.feec.vutbr.cz>
Date: Wed, 15 Dec 2004 13:49:41 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org
Subject: Re: realtime preempt 2.6.10-rc3-mm1-V0.33-0
References: <200412141123.02293.gene.heskett@verizon.net>
In-Reply-To: <200412141123.02293.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Q: Where have the 'nv' drivers gone in the make xconfig display? 
> I just bought a Chaintech Gforce 5200 and cannot find the driver
> in the menu so I can make the module.

It was never in the kernel. The 'nv' driver is a part of XFree86/X.org.

Michal

