Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbTAJFf4>; Fri, 10 Jan 2003 00:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262877AbTAJFfz>; Fri, 10 Jan 2003 00:35:55 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:26145 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S262821AbTAJFfx>; Fri, 10 Jan 2003 00:35:53 -0500
Message-ID: <3E1E5DF5.70808@emageon.com>
Date: Thu, 09 Jan 2003 23:45:25 -0600
From: Brian Tinsley <btinsley@emageon.com>
Organization: Emageon
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20, .text.lock.swap cpu usage? (ibm x440)
References: <3E1E3B64.5040803@emageon.com> <20030110032937.GI23814@holomorphy.com> <3E1E410E.5050905@emageon.com> <20030110035412.GJ23814@holomorphy.com> <3E1E4757.3060206@emageon.com> <20030110041918.GK23814@holomorphy.com> <3E1E50FB.4000301@emageon.com> <20030110052439.GL23814@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Okay, can you try with either 2.4.x-aa or 2.5.x-CURRENT?
>
Yes, I *just* booted a machine with 2.4.20-aa1 in our lab. I was having 
problems compiling the Linux Virtual Server code, but it's fixed now. 

>I'm suspecting either bh problems or lowpte problems.
>
>Also, could you monitor your load with the scripts I posted?
>  
>
Yes, they are already uploaded to a customer site and ready to go. I 
need to flex the -aa1 kernel a bit before I load it there as well.


Thanks!


