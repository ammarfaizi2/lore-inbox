Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUEaRei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUEaRei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUEaRei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 13:34:38 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:18323 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264697AbUEaReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 13:34:37 -0400
Message-ID: <40BB6CA8.9070307@myrealbox.com>
Date: Mon, 31 May 2004 10:34:32 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       linux-kernel@vger.kernel.org
Subject: Re: MM patches (was Re: why swap at all?)
References: <E1BTpqM-0005LZ-00@calista.eckenfels.6bone.ka-ip.net> <200405291031.02564.vda@port.imtp.ilyichevsk.odessa.ua> <40B84C85.8010207@yahoo.com.au>
In-Reply-To: <40B84C85.8010207@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

> Yep.
> 
> Thanks to everyone's input I was able to test and adapt my mm work.
> It is hopefully at a stage where it can have wider testing now. It
> is stable on my SMP system under very heavy swapping, but the usual
> caution applies.

Thanks!

This feels quite a bit better on my system.  I'll try and stress it a bit 
more later today or tomorrow, but my system is now usable under heavy io load.

--Andy
