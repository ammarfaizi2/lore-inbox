Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263354AbTFGSja (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 14:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTFGSja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 14:39:30 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:64706 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S263354AbTFGSj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 14:39:29 -0400
Message-ID: <20030607185405.15201.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Lars Unin" <lars_unin@linuxmail.org>
To: james@stev.org
Cc: linux-kernel@vger.kernel.org
Date: Sun, 08 Jun 2003 02:54:05 +0800
Subject: Re: What are .s files in arch/i386/boot
X-Originating-Ip: 62.7.163.64
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What are .s files in arch/i386/boot, are they c sources of some sort?
> > Where can I find the specifications documents they were made from? 
> 
> There are not c files.
> They are assembler files
> 
> Try running gcc on a c file with the -S option
> it will generate the same then you can tweak the
> assembler produced to make it faster.
> 
> 	James
> 
Where can I find the .c files they were made from,
and the spec sheets the .c files were made from? 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze
