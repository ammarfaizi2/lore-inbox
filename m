Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423646AbWJZSbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423646AbWJZSbx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 14:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423693AbWJZSbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 14:31:53 -0400
Received: from 8.ctyme.com ([69.50.231.8]:23724 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S1423646AbWJZSbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 14:31:52 -0400
Message-ID: <4540FF0E.3080104@perkel.com>
Date: Thu, 26 Oct 2006 11:31:42 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
References: <453EEE46.9040600@perkel.com> <p73vem8kyuv.fsf@verdi.suse.de> <453FB661.3020607@perkel.com> <200610261105.52042.ak@suse.de>
In-Reply-To: <200610261105.52042.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamfilter-host: darwin.ctyme.com - http://www.junkemailfilter.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:
>> As of the 2.6.18 released kernel I still had to modify the source code
>> to keep the kernel from locking up on boot. I haven't tried it with
>> 2.6.19rcx yet.
>>     
>
> Modify in what way?
>
> -Andi
>
>   

skip_timer_override = 0


