Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTIDLvB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 07:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTIDLvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 07:51:01 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:8196 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S264925AbTIDLu7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 07:50:59 -0400
From: Michael Frank <mhf@linuxmail.org>
To: albie@alfarrabio.di.uminho.pt, linux-kernel@vger.kernel.org
Subject: Re: How to debug ACPI?
Date: Thu, 4 Sep 2003 19:49:22 +0800
User-Agent: KMail/1.5.2
References: <1062675563.7371.8.camel@eremita.di.uminho.pt>
In-Reply-To: <1062675563.7371.8.camel@eremita.di.uminho.pt>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309041949.22171.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 September 2003 19:39, Alberto Manuel Brandão Simões wrote:
> Hi
>
> I have a Laptop (Clevo is its brand) which has ACPI (I don't know if he
> follow the standards).
>
> With some kernels before I was able to see a /proc/acpi directory with
> some information (most of them wrong, but ok) and I was able to shutdown
> the laptop properly.
>
> With kernel 2.4.22 the /proc/acpi directory does not exist (but I've
> compiled it) and modules ac.o, battery.o and so on give a 'init_module:
> No such device' answer.
>
> I need to make it turn off automatically again, at least. I know I can
> use my last kernel, but it is not quite a good idea, as I would like to
> continue updating my kernel.
>

Could you please send your dmesg to acpi-devel@sourceforge.net, which
is the right list for this.

Regards
Michael

