Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268702AbTHESkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 14:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269559AbTHESkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 14:40:25 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:21523 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S268702AbTHESkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 14:40:22 -0400
Message-ID: <3F2FFD05.90902@techsource.com>
Date: Tue, 05 Aug 2003 14:52:53 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Julien Oster <lkml@mf.frodoid.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Turning off automatic screen clanking
References: <eFZJ.6X7.29@gated-at.bofh.it> <eH5i.7XC.15@gated-at.bofh.it>	<eNaA.4vE.1@gated-at.bofh.it> <eRHk.85K.5@gated-at.bofh.it>	<fmBF.48z.41@gated-at.bofh.it> <fotH.5J2.17@gated-at.bofh.it>	<frB6.8gE.7@gated-at.bofh.it> <frodoid.frodo.87brv7t46v.fsf@usenet.frodoid.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Julien Oster wrote:
> 
> 
> And then I see no point in cycling the colors instead of blanking.
> 


The idea is to save your screen from burn-in AND be able to read it at 
the same time.  I wasn't considering power-saving.  If you keep changing 
the colors on the screen but maintain contrast between characters and 
the background, that would do the trick.

