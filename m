Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTFXPpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTFXPpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:45:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262259AbTFXPpg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:45:36 -0400
Message-ID: <3EF87566.6060703@pobox.com>
Date: Tue, 24 Jun 2003 11:59:34 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephan von Krawczynski <skraw@ithnet.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Broadcom bcm 4401
References: <20030623151040.135133f9.skraw@ithnet.com>	 <1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>	 <3EF860A7.5000102@pobox.com> <1056469248.14611.29.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1056469248.14611.29.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2003-06-24 at 15:31, Jeff Garzik wrote:
> 
>>What cleaning needs to be done?
>>
>>AFAIK, I need only to fix a phy-related bug, and b44 will be working 
>>nicely.  (I have test h/w, too)
> 
> 
> The driver I have is very windowsish, I assumne the one you have is not ?


Look at drivers/net/b44.c in 2.5 :)

It will appear in 2.4 as soon as it works for me.

	Jeff



