Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280320AbRK2TCP>; Thu, 29 Nov 2001 14:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280766AbRK2TCJ>; Thu, 29 Nov 2001 14:02:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:61424 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277380AbRK2TBx>;
	Thu, 29 Nov 2001 14:01:53 -0500
Date: Thu, 29 Nov 2001 10:46:01 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Xiaozhou Qiu <xzqiu@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to communicate between kernel and user space?
In-Reply-To: <F56sjUHQHh2wLCVYl4m0000010f@hotmail.com>
Message-ID: <Pine.LNX.4.10.10111291044490.16407-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2001, Xiaozhou Qiu wrote:

> Hi,
> 
> I am sorry if this is a newbie's question. I am developing a kernel module 
> which needs to call some crypt functions implemented in user space. Since 
> those functions utilize openssl library, I assume there is no easy way to 
> port them into kernel.
> 
> I wonder whether there is an easy and elegant way to call the user space 
> functions from the kernel and get the results, if /proc can not be used.  If 
> anybody knows where I can find a crypt library in the kernel, that will be a 
> great help too.
> 
> Thank you very much.
> 
> Xiaozhou Qiu

So you want to import content encryption from user space to bork the data
in the storage array -- don't think so -- regards.

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project

