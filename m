Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbSLRVMY>; Wed, 18 Dec 2002 16:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbSLRVMY>; Wed, 18 Dec 2002 16:12:24 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:20988 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S264756AbSLRVMY>; Wed, 18 Dec 2002 16:12:24 -0500
Message-ID: <3E00E670.2000706@google.com>
Date: Wed, 18 Dec 2002 13:19:44 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "D.A.M. Revok" <marvin@synapse.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
References: <Pine.LNX.4.10.10212181308340.8350-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>And this is the drive hack job that Promise did to it in 2.4.19.
>This is not my driver version and you need to nail Marcelo for this issue.
>Wait, move to 2.4.20 and it may go away.  Better yet go back to 2.4.18 and
>it should be clean.
>
I'm not sure if the problem code is in the patch from Promise, but I can 
say we have applied the promise supplied patch to 2.4.18 and as a whole 
it is a nightmare.  I don't recomend it if you don't need it.

    Ross


