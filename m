Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbVIDMtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbVIDMtp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 08:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbVIDMtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 08:49:45 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:58303 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750765AbVIDMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 08:49:44 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Alex Davis <alex14641@yahoo.com>
Subject: Re: RFC: i386: kill !4KSTACKS
Date: Sun, 4 Sep 2005 15:49:17 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
In-Reply-To: <20050902060830.84977.qmail@web50208.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509041549.17512.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 September 2005 09:08, Alex Davis wrote:
> ndiswrapper and driverloader will not work reliably with 4k stacks.
> This is because of the Windoze drivers they use, to which, obviously,
> they do not have the source. Since quite a few laptops have built-in
> wireless cards by companies who will not release an open-source driver,
> or won't release specs, ndiswrapper and driverloader are the only way
> to get these cards to work. 
>   Please don't tell me to "get a linux-supported wireless card". I don't
> want the clutter of an external wireless adapter sticking out of my laptop,
> nor do I want to spend money on a card when I have a free and working solution.

Please don't tell me to "care for closed-source drivers". I don't
want the pain of debugging crashes on the machines which run unknown code
in kernel space.

IOW, if you run closed source modules - it's _your_ problem, not ours.
--
vda
