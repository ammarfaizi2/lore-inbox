Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVEaN4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVEaN4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 09:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVEaN4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 09:56:48 -0400
Received: from trixi.wincor-nixdorf.com ([217.115.67.77]:43223 "EHLO
	trixi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S261873AbVEaN4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 09:56:40 -0400
From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       brazilnut@us.ibm.com
Message-ID: <429C6C8F.5000506@wincor-nixdorf.com>
Date: Tue, 31 May 2005 15:54:23 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: pci-irq VIA82C586 problem on IBM 4694-205 kernel version 2.4.29
References: <428379AC.9080206@wincor-nixdorf.com> <20050512162803.GA15201@us.ibm.com>   <42847C64.5080405@wincor-nixdorf.com> <20050513164654.GB30792@us.ibm.com> <4289FF48.9070205@wincor-nixdorf.com>   <20050518113315.GC7793@logos.cnet> <428C43F4.5020709@wincor-nixdorf.com> <20050525115910.GA15873@logos.cnet>
In-Reply-To: <20050525115910.GA15873@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

The patch you have referenced is working correctly on my IBM 4694-205.
Many thanks,
Frank


Marcelo Tosatti wrote:
> 
> 
> Hi Frank,
> 
> A fix for the problem has just been merged in v2.4.31-rc1 - I would 
> appreciate if you can test that.
> 
