Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262276AbTJNJ7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 05:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbTJNJ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 05:59:23 -0400
Received: from mail.convergence.de ([212.84.236.4]:14012 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262276AbTJNJ7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 05:59:22 -0400
Message-ID: <3F8BC8F8.6000909@convergence.de>
Date: Tue, 14 Oct 2003 11:59:20 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/14] LinuxTV.org DVB driver update
References: <20031011105320.1c9d46db.davem@redhat.com>	<Pine.GSO.4.21.0310121115260.27309-100000@starflower.sonytel.be>	<20031012110846.GA1677@mars.ravnborg.org> <20031013090108.3aa8c464.shemminger@osdl.org>
In-Reply-To: <20031013090108.3aa8c464.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen,

> I think root cause of the problem is that dvb was only just been added
> to the MAINTAINERS file so the patch got lost when I sent to closet
> match was the video lists. It was kind of orphan thing since it crossed
> both networking and DVB.

I just browsed thorugh the changelogs at
http://linus.bkbits.net:8080/linux-2.5/src/drivers/media/dvb?nav=index.html|src/.|src/drivers|src/drivers/media
and back-feeded the changes that did not make it into our local CVS yet.

> Do you need any help in reinserting it?

Thanks for your offer. But I have just cut out your patch, "reversed 
it", compile tested it and sent it to lkml.

CU
Michael.

