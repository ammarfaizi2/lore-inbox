Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267434AbUGNO5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267434AbUGNO5f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:57:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267432AbUGNOyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:54:44 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:33292 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S267406AbUGNOxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:53:22 -0400
Message-ID: <40F54E9F.5090800@techsource.com>
Date: Wed, 14 Jul 2004 11:17:51 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Petr Titera <P.Titera@century.cz>
CC: Robert Lowery <rlowery@optusnet.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OT] Belkin Bluetooth Access Point GPL violation
References: <200407100920.i6A9Kr808614@mail001.syd.optusnet.com.au> <40F021B8.1@century.cz>
In-Reply-To: <40F021B8.1@century.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petr Titera wrote:

> Hello,
> 
>    I've try to look at firware image and it really seems that they do 
> not use modules in kernel and that bluetooth drivers are compiled in. So it
> really seems that they should either distribute source for their stack 
> or do not distribute it at all.
> 


Even if they did use modules, the module interface is not necessarily a 
GPL barrier.  The fact that the unit becomes useless if you remove the 
kernel or the bluetooth drivers means that it's a complete work and not 
merely an aggregate.

I don't understand why companies think they can get away with this kind 
of intellectual property theft.

I also don't understand why they don't use BSD instead.  They wouldn't 
have ANY of these problems.

