Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbUKVLUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbUKVLUT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 06:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUKVLSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 06:18:18 -0500
Received: from tri-e2k.ethz.ch ([129.132.112.23]:34608 "EHLO tri-e2k.ethz.ch")
	by vger.kernel.org with ESMTP id S262076AbUKVLRv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 06:17:51 -0500
Message-ID: <41A1CAD4.20101@dbservice.com>
Date: Mon, 22 Nov 2004 12:17:40 +0100
From: Tomas Carnecky <tom@dbservice.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel thoughts of a Linux user
References: <200411181859.27722.gjwucherpfennig@gmx.net> <419CFF73.3010407@dbservice.com> <41A19E44.9080005@hist.no>
In-Reply-To: <41A19E44.9080005@hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2004 11:17:47.0785 (UTC) FILETIME=[E5800790:01C4D084]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
>> Is it possible to have two or more 'workstations' on one computer?
> 
> Yes - thats what the "ruby" kernel patch is all about.  I have a computer
> with two "workstations" at home.  Compared to two computers, it
> saves space, power, parts,  and above all - administrative work.  Only one
> machine to upgrade, secure, configure.
> 

Thanks, that's what I've been looking for...

 From the documentation:
The main problem up to this date (November 2004) is that linux kernel 
has only one behaviour regarding multiple keyboards : any key pressed 
catched on any keyboard is redirected to the one and only active Virtual 
Terminal (VT).

Will this be changed/improved when the console code is moved into 
userspace, like some have proposed?

tom
