Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271373AbTHSQjg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274992AbTHSQSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:18:41 -0400
Received: from mailadsl.gw.pacific.net.au ([202.7.91.241]:58280 "HELO
	adsl.mailcall.com.au") by vger.kernel.org with SMTP id S272503AbTHSQQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:16:56 -0400
Date: Wed, 20 Aug 2003 02:16:57 +1000 (EST)
From: Omar Kilani <ok@mailcall.com.au>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: linux-kernel@vger.kernel.org
Subject: Re: Install new kernel without reboots.
In-Reply-To: <Pine.LNX.4.51.0308191729290.27171@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.21.0308200213510.11034-100000@adm1.mailcall.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Maciej Soltysiak wrote:

> Hi,
> 
> I have heard it is possible to change the kernel without reboots.
> And I am not talking about UML.
> 
> Is it true? I could not find any documents on the web.
> 
> Regards,
> Maciej
> -

As well as kexec, maybe you want to look at the "two kernel monte".
This is what Scyld Beowulf uses to do single kernel image distribution.
Not sure what it's status is for 2.4, though. I'm only using it on 2.2.

Regards,
Omar Kilani

