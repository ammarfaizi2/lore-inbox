Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUJXKRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUJXKRe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 06:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUJXKRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 06:17:34 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22283 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261458AbUJXKPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 06:15:15 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: mike lewis <lachlanlewis@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc4 stability issues
Date: Sun, 24 Oct 2004 13:15:04 +0300
User-Agent: KMail/1.5.4
References: <b98c6b1a041024013067e06b0a@mail.gmail.com>
In-Reply-To: <b98c6b1a041024013067e06b0a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410241315.04728.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 October 2004 11:30, mike lewis wrote:
> Hi All,
> 
> I wouldn't consider my self a complete newb, but you may, so feel free
> to direct me to the newb list if this is where it should be.
> 
> I've recently come across (saved and purchased) a dvb card which is
> only supported by cvs linux-dvb of a few days ago, which in turn
> willonly compile on 2.6.9-rc4.  So I upgraded my kernel to 2.6.9-rc4 a
> week ago, and now I have stability issues and I'm not sure where to
> turn.  I looked through the changelog from 2.6.8 to 2.6.9 and say a
> lot a ACPI changes, so I turned acpi off in my kernel to see if this
> was the source.. It is not..
> 
> The device is remote, so I can only ssh / telnet in to debug.  I'm
> wondering what steps I can take to establish why this particular
> flavour of kernel is not happy on my system.   One issue I have, is
> how to establish the cause of the system freezes?  I'm assuming a
> segfault of some kind or another would be logged somewhere, but they
> do not appear in /var/log/messages..
> 
> Is there any way to log the segfault cause to post/investigate?

Start with describing your problem in detail.
--
vda

