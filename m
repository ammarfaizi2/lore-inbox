Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315690AbSFJSoL>; Mon, 10 Jun 2002 14:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315709AbSFJSoK>; Mon, 10 Jun 2002 14:44:10 -0400
Received: from ip68-9-71-221.ri.ri.cox.net ([68.9.71.221]:57725 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S315690AbSFJSoJ>; Mon, 10 Jun 2002 14:44:09 -0400
Message-ID: <3D04F374.8090001@blue-labs.org>
Date: Mon, 10 Jun 2002 14:44:04 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0+) Gecko/20020501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <3D039D22.2010805@candelatech.com>	<20020609.213440.04716391.davem@redhat.com>	<5.1.0.14.2.20020610220015.040aff60@mira-sjcm-3.cisco.com> <20020610.051857.97850707.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Bmilter: Processing completed, Bmilter version 0.1.0 build 556; timestamp 2002-06-10 14:43:34, message serial number 4117
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would you (David) mind having a file in the kernel that has a 
list/description of such patches and a URL to them?  This is the kind of 
patch I would like to know is available somewhere so I don't spent a 
week looking for it when someone asks about it.

-d

>   would you be willing to accept a patch that enables per-socket
>   accounting with a CONFIG_ option?
>
>What is the point?
>
>If all the dists will enable it then everybody eats the overhead.
>If the dists don't enable it, how useful is it and what's so wrong
>with it being an external patch people just apply when they need to
>diagnose something like this?
>

