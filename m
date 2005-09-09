Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbVIIJHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbVIIJHT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 05:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965106AbVIIJHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 05:07:19 -0400
Received: from ppp59-167.lns1.cbr1.internode.on.net ([59.167.59.167]:21521
	"EHLO triton.bird.org") by vger.kernel.org with ESMTP
	id S965104AbVIIJHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 05:07:17 -0400
Message-ID: <432151B0.7030603@acquerra.com.au>
Date: Fri, 09 Sep 2005 19:11:12 +1000
From: Anthony Wesley <awesley@acquerra.com.au>
Reply-To: awesley@acquerra.com.au
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.13 buffer strangeness
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David, but if you read my original post in full you'll see that I've tried that, and while I can start the write out sooner by lowering /proc/sys/vm/dirty_ratio , it makes no difference to the results that I am getting. I still seem to run out of steam after only 50 seconds where it should take about 3 minutes.

regards, Anthony

-- 
Anthony Wesley
Director and IT/Network Consultant
Smart Networks Pty Ltd
Acquerra Pty Ltd

Anthony.Wesley@acquerra.com.au
Phone: (02) 62595404 or 0419409836

