Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263965AbTJ1NnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 08:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbTJ1NnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 08:43:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54401 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263965AbTJ1NnO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 08:43:14 -0500
Message-ID: <3F9E7262.4010204@pobox.com>
Date: Tue, 28 Oct 2003 08:42:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hasse Hagen Johansen <hhj@musikcheck.dk>
CC: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: question about PDC20378 sata driver
References: <20031028114015.1986.qmail@mail.musikcheck.dk>
In-Reply-To: <20031028114015.1986.qmail@mail.musikcheck.dk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hasse Hagen Johansen wrote:
> I cannot find any information about this. Is it possible to use the 
> ide-raid function of the pdc20378 based chipset builtin on some 
> mainboards, just using the sata driver?

There is no ide-raid function in that chipset ;-)  It is all software RAID.

And as far as I know, the "ata-raid" or "fakeraid" drivers have not yet 
been updated for 2.6.

	Jeff



