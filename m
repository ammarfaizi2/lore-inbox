Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270993AbTGVT3g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 15:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270992AbTGVT3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 15:29:36 -0400
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:41511 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S270184AbTGVT3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 15:29:30 -0400
Message-ID: <3F1D92DD.7040300@rackable.com>
Date: Tue, 22 Jul 2003 12:39:09 -0700
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Promise SATA driver GPL'd
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org>
In-Reply-To: <20030722190705.GA2500@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jul 2003 19:44:32.0875 (UTC) FILETIME=[AC58D3B0:01C35089]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:

>On Tue Jul 22, 2003 at 02:54:43PM -0400, Jeff Garzik wrote:
>  
>
>>Bart, Alan, and I have been looking at this.  It uses the ancient CAM
>>model, that we don't really want to merge directly in the kernel.  It's
>>very close to the libata model, from the user perspective, so life is 
>>good.
>>    
>>
>
>I was reading over your libata driver yesterday.  Certainly a lot
>cleaner than the cam stuff IMHO.  Given the info made available
>via the Promise driver, I expect that I could get an initial
>libata host adaptor driver hacked together in short order.  After
>all, the Intel one is just 400 lines.  So unless you (or anyone
>else) have already started or would prefer to do the honors,
>I'll try to hack something together this evening,
>
>  
>

  I'd be more than happy to test a driver.  I'm sure I've got several 
pci cards plus a few intel 32, and amd-64 motherboards with promise sata 
on board.


-- 
Once you have their hardware. Never give it back.
(The First Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


