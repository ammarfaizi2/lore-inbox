Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263930AbTLXWCK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 17:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTLXWCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 17:02:10 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:27896 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S263930AbTLXWB0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 17:01:26 -0500
Subject: Re: is it possible to have a kernel module with a BSD license?!
From: Stan Bubrouski <stan@ccs.neu.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3FE9ADEE.1080103@baywinds.org>
References: <3FE9ADEE.1080103@baywinds.org>
Content-Type: text/plain
Message-Id: <1072303285.2947.215.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 24 Dec 2003 17:01:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why would anyone want to BSD license a kernel module, honestly...

-sb

On Wed, 2003-12-24 at 10:17, Bruce Ferrell wrote:
> from the project announcement on freshmeat:
> 
> 
>   Dazuko 2.0.0-pre5 (Default)
>   by John Ogness - Tuesday, November 11th 2003 06:56 PST
> 
> About:
> This project provides a kernel module which provides 3rd-party 
> applications with an interface for file access control. It was 
> originally developed for on-access virus scanning. Other uses include a 
> file-access monitor/logger or external security implementations. It 
> operates by intercepting file-access calls and passing the file 
> information to a 3rd-party application. The 3rd-party application then 
> has the opportunity to tell the kernel module to allow or deny the 
> file-access. The 3rd-party application also receives information about 
> the file, such as type of access, process ID, user ID, etc.
> 
> Release focus: Minor bugfixes
> 
> Changes:
> Some "in use" problems with spontaneous context-switches when unloading 
> under FreeBSD were fixed. Macros for hooking/unhooking system calls were 
> added. Filename length restrictions were removed. Code for generating 
> protocol13 was abstracted and moved into XP layer. Support for filenames 
> with non-printable characters was added. The ability to compile the 
> interface library without 1.x compatibility was added. An "off by one" 
> bug which occurred when calculating include/exclude path lengths was 
> fixed. Support for Linux 2.6 kernels was added (not yet complete, but 
> very functional).
> 
>                                  Last release   	 License   	
> Default 	2.0.0-pre5 	24-Dec-2003 	BSD License (revised)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

