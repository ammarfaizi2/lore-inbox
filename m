Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263311AbTDRXzp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 19:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263314AbTDRXzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 19:55:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50409 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263311AbTDRXzo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 19:55:44 -0400
Message-ID: <3EA09337.3010900@pobox.com>
Date: Fri, 18 Apr 2003 20:07:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: Petr Konecny <pekon@informatics.muni.cz>, linux-kernel@vger.kernel.org,
       Dave Jones <davej@codemonkey.org.uk>, Jurriaan <thunder7@xs4all.nl>
Subject: Re: My P3 runs at.... zero Mhz (bug rpt)
References: <200304182350.h3INoC728630@devserv.devel.redhat.com>
In-Reply-To: <200304182350.h3INoC728630@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>It does not help me with 2.5.67-ac2 + pcmcia patch. I get 0.000 MHz,
>>589.82 BogoMIPS with or without CPUFreq. It did the same thing with
>>2.5.67-ac1 (did not test w/o CPUFreq).
> 
> 
> Its a bug in the mach- patches. Someone sent a fix to l/k


Yep.  Linus committed a better fix, too.  :)

	Jeff



