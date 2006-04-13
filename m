Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWDMUjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWDMUjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWDMUjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:39:42 -0400
Received: from dvhart.com ([64.146.134.43]:11725 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S932459AbWDMUjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:39:41 -0400
Message-ID: <443EB70B.3080908@mbligh.org>
Date: Thu, 13 Apr 2006 13:39:39 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: K P <kplkml@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com> <443E74C1.5090801@mbligh.org> <443EBC1D.1000307@wolfmountaingroup.com>
In-Reply-To: <443EBC1D.1000307@wolfmountaingroup.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Note they ran the benchmark on an Opteron 285 instead of a Xeon with 
> 16 GB of memory.    Opteron peformance currently **SUCKS** with 2.6 
> series kernels under any kind of heavy I/O due to their cloning of the 
> ancient 82489DX architecture for I/O interrupt access and 
> performance.  Looks like the test was stakced against Linux from the 
> start.  Should have used a Xeon system.
> AMD needs to get their crappy I/O performance up to snuff.  Looking at 
> the test parameteres leads me to believe there was a lot of swapping 
> on a system with already poor I/O performance.
>

Looks to me like it was the same h/w for Linux as Solaris, so I don't
think that's much of an excuse ;-)

M.

