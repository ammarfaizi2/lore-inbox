Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263483AbUDEWIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 18:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263480AbUDEWGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 18:06:17 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:3845 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263487AbUDEWBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 18:01:47 -0400
Message-ID: <4071DC20.6040005@techsource.com>
Date: Mon, 05 Apr 2004 18:22:24 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: Chris Wright <chrisw@osdl.org>, John Stoffel <stoffel@lucent.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405214007.68717.qmail@web40506.mail.yahoo.com>
In-Reply-To: <20040405214007.68717.qmail@web40506.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergiy Lozovsky wrote:

> 
> 
> LSM use another way of doing similar things :-) I'm
> not sure that it is nice to forward system calls back
> to userspace where they came from in the first place
> :-) VXE use high level language to create security
> models.
> 

"Kernel space -> user space -> kernel space" is nothing compared to the 
overhead of a LISP interpreter.

Doing interpretation of LISP is a monster compared to some piddly 
context switches.

