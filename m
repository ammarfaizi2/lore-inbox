Return-Path: <linux-kernel-owner+w=401wt.eu-S964902AbXASVTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbXASVTx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 16:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbXASVTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 16:19:53 -0500
Received: from mail.tmr.com ([64.65.253.246]:48761 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964902AbXASVTw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 16:19:52 -0500
Message-ID: <45B136A0.3030503@tmr.com>
Date: Fri, 19 Jan 2007 16:22:40 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Probably wrong place to ask
References: <200701191457.46798.gene.heskett@verizon.net>
In-Reply-To: <200701191457.46798.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> Greetings all;
> 
> I have a card reader plugged into a usb port.  I recognizes a 512meg pny 
> cf card just fine, but wwhen I plug in a 256meg Lexar cf, the led comes 
> on, but there is no reaction from linux. /dev/sda is not created, 
> nothing.
> 
> Is this a kernel config problem, or is this particular cf known to be a 
> bad bird?
> 
I do that with CF and memory stick, what kernel, distribution, etc? I 
would suspect something in hotplug not noticing.

I presume you have tried this from cold boot, so any issues with 
unplugging and plugging another flash are removed.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
