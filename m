Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTJIQ4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 12:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262330AbTJIQ4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 12:56:37 -0400
Received: from fep03-svc.mail.telepac.pt ([194.65.5.202]:5003 "EHLO
	fep03-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S262319AbTJIQ4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 12:56:36 -0400
Message-ID: <3F8592D6.6090905@vgertech.com>
Date: Thu, 09 Oct 2003 17:54:46 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030908 Debian/1.4-4
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: herft <herft@sedal.usyd.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: CPU Usage for particular User Login
References: <5.1.1.5.2.20031009193818.0233ebf8@brain.sedal.usyd.edu.au>
In-Reply-To: <5.1.1.5.2.20031009193818.0233ebf8@brain.sedal.usyd.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



herft wrote:
> Hi Vda,
> Hi All.
> 
> I want to get CPU Usage for particular User Login. (Seperately for each 
> user)
> 
> IS THERE AN APPLICATION WHICH RUNS UNDER Linux to do this work?

This is a bit off-topic for lkml, but...

AFAIK, no. You'll have to code your own.

You can also run a lot of top programs, each for one user (type 'u' 
while in top).

Regards,
Nuno Silva

> 
> 
> Thanks
> 
> Sena Seneviratne
> Computer Engineering Lab
> Sydney University
>

