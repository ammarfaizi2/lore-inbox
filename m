Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVJQJ7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVJQJ7Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 05:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVJQJ7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 05:59:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34514 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932243AbVJQJ7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 05:59:15 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <4353770F.3010605@s5r6.in-berlin.de>
Date: Mon, 17 Oct 2005 12:03:59 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
CC: Andrew Morton <akpm@osdl.org>, jbarnes@virtuousgeek.org, rob@janerob.com
Subject: Re: ohci1394 unhandled interrupts bug in 2.6.14-rc2
References: <20051015185502.GA9940@plato.virtuousgeek.org>	<43515ADA.6050102@s5r6.in-berlin.de>	<20051015202944.GA10463@plato.virtuousgeek.org>	<20051017005515.755decb6.akpm@osdl.org>	<4353705D.6060809@s5r6.in-berlin.de> <20051017024219.08662190.akpm@osdl.org>
In-Reply-To: <20051017024219.08662190.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.779) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>>Of course we don't have a complete picture of which models are affected 
>>though.
> 
> I suppose we could do both.  As people are found who need the module
> parameter, we grab their DMI strings and add them to the table?

Jesse, what DMI_PRODUCT_NAME matches your laptop?
-- 
Stefan Richter
-=====-=-=-= =-=- =---=
http://arcgraph.de/sr/

