Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272153AbTG2TYe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272154AbTG2TYe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:24:34 -0400
Received: from diomedes.noc.ntua.gr ([147.102.222.220]:15937 "EHLO
	diomedes.noc.ntua.gr") by vger.kernel.org with ESMTP
	id S272152AbTG2TY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:24:28 -0400
Message-ID: <3F26CAF2.8070009@gmx.net>
Date: Tue, 29 Jul 2003 22:28:50 +0300
From: jimis@gmx.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related) -- conclusion
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all very much for your answers, I 've learned a lot. However I have 
some comments to make concerning the two proposals I made:

1) Network traffic scheduling. I 've studied a little the linux advanced routing 
and traffic control HOWTO and the wondershaper script and I think they are 
great, I had no idea of this potential. But what I propose is scheduling the 
network traffic (at least the outgoing traffic that we can influence directly) 
according to the process priority, not according to the traffic type (which is 
important but different).

2) Disk I/O scheduling, again according to the process priority. From some posts 
I found out that there was a patch that did that, but I don't know where it is 
or if it is up to date with newer kernels.

I hope I clarified myself and I believe these features would be useful if 
included in the kernel.

Thanks,
Dimitris

P.S. Please forward me any replies


