Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVHBWqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVHBWqc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 18:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVHBWqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 18:46:32 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58785 "EHLO
	smtp-out5.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S261480AbVHBWqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 18:46:31 -0400
Message-ID: <42EFF7C8.1060804@blueyonder.co.uk>
Date: Tue, 02 Aug 2005 23:46:32 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Touchpad errors
References: <42EF633B.6080209@blueyonder.co.uk>	 <d120d500050802072256a4d7ee@mail.gmail.com>	 <2ac89c700508021314f42da6a@mail.gmail.com> <1123014056.12562.24.camel@mindpipe>
In-Reply-To: <1123014056.12562.24.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Aug 2005 22:47:16.0436 (UTC) FILETIME=[21A5F940:01C597B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Wed, 2005-08-03 at 00:14 +0400, Dmitrij Bogush wrote:
> 
>>This happens when some software check battery state or current cpu
>>rate too often.
> 
> 
> Acer laptops are notorious for buggy SMM implementations that disable
> interrupts for many timer ticks.  Does it work any better with HZ=100?
> 
> Lee
> 
> 
> 

The problem, initially at least, doesn't seem as sever at HZ=100, 18 
occurrences in 3 mins 30 seconds.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Keen licensed Private Pilot
Retired IBM Mainframes and Sun Servers Tech Support Specialist
Microsoft Windows Free Zone - Linux used for all Computing Tasks
