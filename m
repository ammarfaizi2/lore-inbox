Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVE3SKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVE3SKi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 14:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVE3SKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 14:10:38 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:40452 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S261668AbVE3SJV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 14:09:21 -0400
Message-ID: <429B56CA.5080803@rtr.ca>
Date: Mon, 30 May 2005 14:09:14 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050420 Debian/1.7.7-2
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Erik Slagter <erik@slagter.name>
Cc: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
Subject: Re: Playing with SATA NCQ
References: <20050526140058.GR1419@suse.de>	 <1117382598.4851.3.camel@localhost.localdomain>	 <4299F47B.5020603@gmail.com>	 <1117387591.4851.17.camel@localhost.localdomain>  <429A58F4.3040308@rtr.ca> <1117438192.4851.29.camel@localhost.localdomain>
In-Reply-To: <1117438192.4851.29.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Slagter wrote:
> On Sun, 2005-05-29 at 20:06 -0400, Mark Lord wrote:
> 
>>>ICH6M (mobile/no raid) on a Dell Inspiron 9300 laptop. AFAIK there are
>>>no plans to implement support for AHCI transition in the BIOS. &^$##($%
>>>DELL.
> I really have a (native) SATA drive, I checked the ID from dmesg.

Seems rather unlikely that they would plumb the same notebook both ways.
The 100GB drive in the i9300 here is a "FUJITSU MHV2100AH" (PATA).

Cheers
