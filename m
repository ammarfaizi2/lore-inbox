Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWG3NUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWG3NUc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 09:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbWG3NUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 09:20:32 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:7351 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750833AbWG3NUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 09:20:31 -0400
Message-ID: <44CCB21C.1050206@lwfinger.net>
Date: Sun, 30 Jul 2006 08:20:28 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: V2.6.18-rc2-latest git compilation fails on i386
References: <44CC18B2.4040309@lwfinger.net> <9a8748490607292127ncea6bcep89f9841a09411b3@mail.gmail.com>
In-Reply-To: <9a8748490607292127ncea6bcep89f9841a09411b3@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 30/07/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> When compiling the latest i386 kernel from Linus's tree with 
>> CONFIG_STACK_UNWIND
>> defined, the following compilation error occurs:
>>
> I reported that problem yesterday and Alexey Dobriyan provided a fix :
> http://lkml.org/lkml/2006/7/29/85
> 

I don't subscribe to LKML and I missed your report of this problem in the summary.
Sorry for the noise.

Larry

