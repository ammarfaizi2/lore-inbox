Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSKZTFT>; Tue, 26 Nov 2002 14:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266540AbSKZTFT>; Tue, 26 Nov 2002 14:05:19 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:58566 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266535AbSKZTFS>; Tue, 26 Nov 2002 14:05:18 -0500
Message-ID: <3DE3C79C.20306@nortelnetworks.com>
Date: Tue, 26 Nov 2002 14:12:28 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Richard B. Tilley (Brad)" <rtilley@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiler & Statically Linked Question
References: <1038336619.7793.28.camel@oubop4.bursar.vt.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Tilley (Brad) wrote:

> I would like to have one build machine where I build a kernel and then
> use that kernel on all of the test PCs. I do not want to build a kernel
> for each machine.

Build all the kernels for the lowest common denominator of processor, 
and compile in all the drivers for all the hardware.

> The PCs have very different hardware and I'd like to play around with
> different c libraries on these PCs. So, what would be the best way to
> build a kernel that would work in this type of environment?

The kernel has nothing to do with different C libraries.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

