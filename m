Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTIOLoV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 07:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTIOLoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 07:44:21 -0400
Received: from [217.222.53.238] ([217.222.53.238]:33555 "EHLO mail.gts.it")
	by vger.kernel.org with ESMTP id S261265AbTIOLoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 07:44:20 -0400
Message-ID: <3F65A611.9060705@gts.it>
Date: Mon, 15 Sep 2003 13:44:17 +0200
From: Stefano Rivoir <s.rivoir@gts.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-t4/5] Error inserting module snd
References: <3F65A230.3020806@gts.it> <20030915113446.GF1091@Synopsys.COM>
In-Reply-To: <20030915113446.GF1091@Synopsys.COM>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Riesen wrote:

> Stefano Rivoir, Mon, Sep 15, 2003 13:27:44 +0200:
> 
>>When inserting module snd, modprobe bails out saying
>>
>>snd: Unknown parameter 'device_mode'
> 
> 
> remove the parameter (device_mode). It could be in modprobe.conf, or in
> your modprobe command line. There could be possibly others, obsoleted
> parameters, so be prepared to remove more.

Right, too easy, more than what I thought (it's easy to give the fault 
to the kernel in these -testX days :P)

Thanks

-- 
Stefano RIVOIR




