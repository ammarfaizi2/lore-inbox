Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTFXLG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 07:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTFXLG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 07:06:27 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:25094 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261932AbTFXLG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 07:06:26 -0400
From: vanstadentenbrink@ahcfaust.nl
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Jun 2003 13:20:36 +0200
MIME-Version: 1.0
Subject: RE: GPL violations by wireless manufacturers
Message-ID: <3EF85024.4477.78EB14@localhost>
In-reply-to: <MDEHLPKNGKAHNMBLJOLKKEEDDOAA.davids@webmaster.com>
References: <3EF83FAF.24578.38A16F@localhost>
X-mailer: Pegasus Mail for Windows (v4.11)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies as I am not subscribed ]

In response to DS:

> So is a Linux distribution "a whole which is a work based on the" Linux
> kernel? Would you argue that RedHat can't include proprietary software on
> the same CD as the Linux kernel? All the software on the CD, assuming it's
> Linux software, likewise extends the kernel through a well-defined boundary.

No, definitely not. If that were the case, SuSE and Lindows etc. etc. 
would not be able to distribute proprietary software together with 
GPL'ed software. The GPL calls this 'mere aggregation':

"In addition, mere aggregation of another work not based on the 
Program with the Program (or with a work based on the Program) on a 
volume of a storage or distribution medium does not bring the other 
work under the scope of this License."

These wireless products are different. The user doesn't have a choice 
to use or not to use the non-gpl'ed kernel module. He can not prevent 
the module from loading, he can not remove it from the running kernel 
and the device doesn't operate without the module. The module and the 
embedded Linux OS on the device are so interconnected that they can 
not be considered 'seperate works' under the GPL. Therefore the 
kernel module actually is GPL software itself.

Buffalo Technology's response indicates that they agree with me (or 
perhaps they just don't want any trouble).

In response to Zack Gilburd:

> ...But where are the downloads? :-\

They don't have to offer the source as a download under the GPL. They 
just have to enable you to get to the source. As soon as Buffalo puts 
on the their website that they use GPL'ed software (they said they 
would do that within 48 hours) you should be able to request and 
receive the source code of the embedded Linux OS as well as the 
source code of the kernel module.


Richard Ten Brink
