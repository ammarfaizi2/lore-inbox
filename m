Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270478AbTGUQdD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 12:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270496AbTGUQdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 12:33:03 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:18308 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S270478AbTGUQdB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 12:33:01 -0400
From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
To: Mathieu Chouquet-Stringer <mathieu@newview.com>
Subject: Re: how to calculate the system idle time
Date: Mon, 21 Jul 2003 13:48:07 -0300
User-Agent: KMail/1.5.1
Cc: snoopyzwe <snoopyzwe@sina.com>, root@chaos.analogic.com,
       linux-kernel@vger.kernel.org
References: <3F1C570E.8080607@sina.com> <200307211245.34244.lucasvr@gobolinux.org> <xlt1xwjam7e.fsf@shookay.newview.com>
In-Reply-To: <xlt1xwjam7e.fsf@shookay.newview.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307211348.07751.lucasvr@gobolinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 July 2003 13:17, Mathieu Chouquet-Stringer wrote:
> lucasvr@gobolinux.org (Lucas Correia Villa Real) writes:
> > "top" is an utility that cames with the Procps package.
>
> But that's probably not what he needs anyway: by idle time he meant "no
> keyboard and mouse input". He should take a look at /proc/interrupts IMHO.

Ah, sure! He can give a look on Documentation/filesystems/proc.txt for more 
information about it.

Lucas

