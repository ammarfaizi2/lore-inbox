Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbTDKUwl (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbTDKUwk (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:52:40 -0400
Received: from www.wotug.org ([194.106.52.201]:50221 "EHLO
	gatemaster.ivimey.org") by vger.kernel.org with ESMTP
	id S261883AbTDKUwi (for <rfc822;Linux-Kernel@vger.kernel.org>); Fri, 11 Apr 2003 16:52:38 -0400
Message-Id: <5.2.0.9.0.20030411220326.0258e5d0@mailhost.ivimey.org>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 11 Apr 2003 22:04:19 +0100
To: "Riley Williams" <Riley@Williams.Name>,
       "Linux Kernel List" <Linux-Kernel@vger.kernel.org>,
       "Robert White" <rwhite@casabyte.com>
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
Subject: Re: kernel support for non-English user messages
In-Reply-To: <BKEGKPICNAKILKJKMHCAKEBJCGAA.Riley@Williams.Name>
References: <PEEPIDHAKMCGHDBJLHKGMEPICGAA.rwhite@casabyte.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:21 11/04/2003, Riley Williams wrote:
>It would also have to handle all the cases of...
>
>         #define CMD_PRINT(x...)   printk(KERN_INFO x)
>         :
>
>         CMD_PRINT("This is some useless information");


Personally, I feel there ought to be a standard set of these macros that 
can be used. Everyone keeps reinventing the same wheel :-(

Ruth 

