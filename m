Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbTIMWeI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 18:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262248AbTIMWeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 18:34:08 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19144 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262245AbTIMWd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 18:33:59 -0400
Message-ID: <3F639B49.8010409@pobox.com>
Date: Sat, 13 Sep 2003 18:33:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
References: <20030913125103.GE27368@fs.tum.de> <20030913161149.GA1750@redhat.com> <20030913182159.GA10047@gtf.org> <20030913183758.GQ1191@redhat.com> <20030913185319.GC10047@gtf.org> <20030913220706.GM27368@fs.tum.de>
In-Reply-To: <20030913220706.GM27368@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> I'm not sure whether you understand my intention.
> 
> Nothing will change, except that if you want to support all CPUs, you 
> have to select all CPUs instead of 386.

This is incorrect.  You don't want to change the behavior that people 
are relying on.  I wasn't describing your intentions, I was describing 
what you _should_ do ;-)

	Jeff



