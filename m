Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272459AbTHNQGe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 12:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272473AbTHNQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 12:06:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:3525 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272459AbTHNQGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 12:06:25 -0400
Date: Thu, 14 Aug 2003 09:04:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3 - the state of ACPI STR?
In-Reply-To: <200308141947.53641.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.33.0308140903260.916-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I compiled kernel with CONFIG_ACPI_SLEEP=y but doing echo 3 > /proc/acpi/sleep 
> just hangs; SysRq works but task list is too long for video console.
> 
> if it is supposed to work I probably arrange for serial output; the system is 
> ASUS CUSL2 desktop, STR works under Windows.

It does not consistently work at the moment. We're currently working on 
the infrastructure to get it working, so hang tight..

Thanks,


	-pat

