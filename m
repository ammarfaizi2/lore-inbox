Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTKROEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 09:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTKROEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 09:04:33 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5094 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262787AbTKROE3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 09:04:29 -0500
Message-ID: <3FBA26D1.8050901@pobox.com>
Date: Tue, 18 Nov 2003 09:04:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Catani, Antonio" <Antonio.Catani@seceti.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm3 and enanched IDE mode on p4c800 deluxe
References: <9E8BE1B970A998468D92381A112AA3EA0140E9@srvrm001.roma.seceti.it>
In-Reply-To: <9E8BE1B970A998468D92381A112AA3EA0140E9@srvrm001.roma.seceti.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Catani, Antonio wrote:
> Hi list, i can non know if my request is in topic or not.
> I have p4c800 deluxe from asus, and works fine with mm3 patch, but I'v
> notice a little beat strange thing in bios of this mobo there is a
> option for setting ide interface in enanched mode, so if I set on the
> kernel start and in dmesg I see ICH-5 100% native mode but after mount
> root I get many of disabled irq 169 and the system hangs so to reset
> hardware.
> 
> In compatible mode the system works fine, but I see in dmesg ICH-5 not
> 100% native mode, will probe irq later, someone can explain me the
> difference about two behavior?


Are you using Serial ATA?

	Jeff



