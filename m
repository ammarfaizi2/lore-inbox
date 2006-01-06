Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932628AbWAFDSY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbWAFDSY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 22:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932629AbWAFDSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 22:18:24 -0500
Received: from xenotime.net ([66.160.160.81]:1722 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932628AbWAFDSX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 22:18:23 -0500
Date: Thu, 5 Jan 2006 19:18:19 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: =?ISO-8859-1?B?SGFucy1K/HJnZW4=?= Lange 
	<Hans-Juergen.Lange@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.x on IBM thin client 8363
Message-Id: <20060105191819.594767e0.rdunlap@xenotime.net>
In-Reply-To: <43BD0E1C.9060705@gmx.de>
References: <43BD0E1C.9060705@gmx.de>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2006 13:16:28 +0100 Hans-Jürgen Lange wrote:

> Hello,
> 
> I would like to run a 2.6.x kernel on a IBM thin client 8363. There are 
> patches available for the 2.4 series of kernels.
> I had a look on these patches and the only thing they do is to expand 
> the kernel commandline size to 512 Bytes and a change in 
> arch/i386/kernel/head.S that changed the pointer to the commandline to a 
> fixed address.

Where are these 2.4 patches that you are referring to?

> In the 2.4.kernel the kernel parameter and command line are ,,moved out 
> of the way''  in two steps. And the second step is the one that get patched.
> In the 2.6 kernel this is done in one step. I did get an explanation of 
> the startup code for the 2.4. kernel but not for the 2.6. I believe that 
> it is no problem to make the changes to get the IBM 8363 running.
> 
> I have seen that some people use this machine but all what use the 
> newest kernel.
> 
> If someone could help me to understand what is going on in the startup 
> code or may have a ready to use solution for this problem it would be 
> very nice if you could help with get it running.


---
~Randy
