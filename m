Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTLECGr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTLECGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:06:47 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:5343 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S263806AbTLECGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:06:43 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Nick Piggin <piggin@cyberone.com.au>
Date: Thu, 04 Dec 2003 18:07:59 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: linux-kernel@vger.kernel.org
Message-ID: <3FCF77FF.18046.447204E6@localhost>
In-reply-to: <3FCFCC3E.8050008@cyberone.com.au>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:

> What about specifically a module that includes the Linux Kernel's
> headers and uses its APIs? I don't think you could say that is
> definitely not a derivative work. 

You cannot copyright an API - people have been down that path before in 
the proprietry software community and have not succeeded. You can 
copyright the code in the header files, but does simply using the header 
files to build a program mean that the driver is now infected? If the 
header files include lots and lots of inline functions that ended up 
compiled into the code, then maybe.

Then again, it appears that most developers are using wrapped to avoid 
this situation, such that their private code does not include any Linux 
headers, only the GPL'ed wrapper.

So we go in circles again.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

