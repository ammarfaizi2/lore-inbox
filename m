Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbUFEU5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbUFEU5g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 16:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261988AbUFEU5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 16:57:36 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:64004 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261951AbUFEU51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 16:57:27 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Harald Dunkel <harald.dunkel@t-online.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6 & prism54: Computer gets stuck pretty often
Date: Sat, 5 Jun 2004 23:56:53 +0300
User-Agent: KMail/1.5.4
References: <40C060C3.7020801@t-online.de>
In-Reply-To: <40C060C3.7020801@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406052356.53200.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 June 2004 14:45, Harald Dunkel wrote:
> Hi folks,
>
> I am not sure how to reproduce this reliably, but using
> the prism54 device my i386 machine gets stuck pretty often
> (about 3 times a day). The mouse freezes, I cannot switch
> to another vt, but Alt-SysRq-b works.

Driver for prism54 is pretty young. Please visit prism54.org
and fill in a bug report. Consider reading already existing bug
reports too.

> If I use an old 3c59x PCI card to connect to the net, then
> there is no such problem.
--
vda

