Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTJSRYL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 13:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTJSRYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 13:24:11 -0400
Received: from ncircle.nullnet.fi ([62.236.96.207]:39072 "EHLO
	ncircle.nullnet.fi") by vger.kernel.org with ESMTP id S261906AbTJSRYJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 13:24:09 -0400
Message-ID: <41102.192.168.9.10.1066584247.squirrel@ncircle.nullnet.fi>
In-Reply-To: <1066579176.7363.3.camel@milo.comcast.net>
References: <00b801c3955c$7e623100$0514a8c0@HUSH>
    <1066579176.7363.3.camel@milo.comcast.net>
Date: Sun, 19 Oct 2003 20:24:07 +0300 (EEST)
Subject: Re: HighPoint 374
From: "Tomi Orava" <Tomi.Orava@ncircle.nullnet.fi>
To: "Joel Smith" <joelsmith17@comcast.net>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
>> What's the current status of HPT 374 support? Is it working in any
>> kernel
>> version?
>
> In 2.4.21 and 2.4.22 it's working great for me.  I'm using the
> "experimental" IDE Raid with two disks on a HPT 374 controller with the
> drivers that come with the kernel.

I have tried these versions in the past as well without success.
However, I don't use HPT-raid features at all ie. I'm using the
disks as JBOD. What hardware do you have and have you enabled
ACPI/local-apic/io-apic ? What brand & model of disk-drives you
are using with HPT374 controller ? And finally what does
the /proc/interrupts show for you ?

There really must be some explanation why some of us are
having really huge problems with HPT374-contollers while for
others it's working just fine. I haven't exactly heard anyone
been too succesfull for example with Epox 8K9A3+ motherboard
even on this mailing-list based on previous questions seen here.

Regards,
Tomi Orava

