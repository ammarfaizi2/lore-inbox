Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTFFRIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 13:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbTFFRIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 13:08:00 -0400
Received: from mail.ithnet.com ([217.64.64.8]:39441 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262143AbTFFRH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 13:07:58 -0400
Date: Fri, 6 Jun 2003 19:21:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ho Lee <Ho_Lee@sdesigns.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to turn off ide dma ...
Message-Id: <20030606192120.1b5185d9.skraw@ithnet.com>
In-Reply-To: <9F77D654ED40B74CA79E5A60B97A087B07C313@sd-exchange.sdesigns.com>
References: <9F77D654ED40B74CA79E5A60B97A087B07C313@sd-exchange.sdesigns.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jun 2003 10:22:52 -0700 
Ho Lee <Ho_Lee@sdesigns.com> wrote:

> 
> ide=nodma option would help you. It disables DMA on every
> IDE interfaces. 

Thanks, I know that. My problem is disabling DMA on _certain_ ide devices,
while others remain with DMA enabled. How do you do that?

Regards,
Stephan

 
> Regards,
> Ho
> 
> -----Original Message-----
> From: Stephan von Krawczynski [mailto:skraw@ithnet.com]
> Sent: Friday, June 06, 2003 5:25 AM
> To: linux-kernel
> Subject: How to turn off ide dma ...
> 
> 
> for certain devices as boot-option in kernel 2.4.20 ?
> 
> E.g. you have three devices and want one of them (not all) to come up PIO
> instead of DMA.
> As using hdparm gives errors and delays for about 20-30 seconds on this
> device
> it would be better to turn it off right from the beginning.
> 
> Regards,
> Stephan
