Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266538AbUJLSSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266538AbUJLSSh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUJLSQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:16:30 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266538AbUJLSPj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:15:39 -0400
Date: Tue, 12 Oct 2004 14:15:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephan <support@bbi.co.bw>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fw: Problem compiling linux-2.6.8.1......
In-Reply-To: <003101c4b086$6c05eb50$0200060a@STEPHANFCN56VN>
Message-ID: <Pine.LNX.4.61.0410121410550.3902@chaos.analogic.com>
References: <003101c4b086$6c05eb50$0200060a@STEPHANFCN56VN>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Stephan wrote:

> hmm , I failed to mention that I'm running redhat ES 3. Don't know if this 
> matters.
>
> Here's the full print out.
>
> gcc (GCC) 3.2.3 20030502 (Red Hat Linux 3.2.3-42)
> Copyright (C) 2002 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> Kind Regards
> Stephan
>
>
>
>> gcc (GCC) 3.2.3 20030502
>>

I think you might need to upgrade some tools. Look in 
linux-n.n.n/Documentation/Changes. The kernel uses a
lot of "GNU-isms" that change from time-to-time.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.8 on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

