Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264830AbTCEI4T>; Wed, 5 Mar 2003 03:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264844AbTCEI4T>; Wed, 5 Mar 2003 03:56:19 -0500
Received: from [196.12.44.6] ([196.12.44.6]:12727 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S264830AbTCEI4S>;
	Wed, 5 Mar 2003 03:56:18 -0500
Date: Wed, 5 Mar 2003 14:35:54 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: Prasad Kamath <prasadk@cisco.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question on writing a socket program in kernel
In-Reply-To: <4.3.2.7.2.20030305123720.02080f00@cbin3-mira-01.cisco.com>
Message-ID: <Pine.LNX.4.44.0303051434390.6355-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



just have a look at the tux or the khttpd module in the kernel. They would 
be of a good help.  You can find them in the net directtory.  If you think 
its still not clear, i can send you some sample code.

Prasad

On Wed, 5 Mar 2003, Prasad Kamath wrote:

> Hi all,
>           I am trying to develop a communication system which will run as a 
> kernel module.  I would like to have all the functionalities of the socket 
> in the kernel level.  I would like to have asynchronous socket.  How do I 
> go about it?
> 
> regards
> Prasad Kamath
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Failure is not an option

