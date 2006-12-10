Return-Path: <linux-kernel-owner+w=401wt.eu-S1762396AbWLJXVh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762396AbWLJXVh (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762424AbWLJXVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:21:37 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48330 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762364AbWLJXVh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:21:37 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457C9660.8040504@s5r6.in-berlin.de>
Date: Mon, 11 Dec 2006 00:21:04 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@bitplanet.net>,
       linux1394-devel@lists.sourceforge.net,
       Erik Mouw <erik@harddisk-recovery.com>,
       Marcel Holtmann <marcel@holtmann.org>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com>	 <1165308400.2756.2.camel@localhost> <45758CB3.80701@redhat.com>	 <20061205160530.GB6043@harddisk-recovery.com>	 <20060712145650.GA4403@ucw.cz> <45798022.2090104@s5r6.in-berlin.de> <59ad55d30612091144s8356d7dw7c68530238ac79e7@mail.gmail.com> <457C042F.3040903@s5r6.in-berlin.de> <457C8791.9000201@redhat.com>
In-Reply-To: <457C8791.9000201@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Stefan Richter wrote:
>>     as the others. hpsb_ is not just an abbreviation, it is an established
>>     acronym of the canonical name of the bus.)
> 
> Oh, I don't know... for the longest time I didn't know what hpsb meant,
> and high performance serial bus is pretty generic sounding... are we
> talking about usb, sata, ieee1394 or rs232?  Ok, I guess rs232 is
> neither hp or b.  But seriously, except for the current stack, I've
> never seen the hpsb abbreviation used much.

Sure, by "established" I merely meant "established for and by usage
in Linux kernel sources", nothing more. Also, High Performance Serial
Bus is not the only generic sounding name of a bus or architecture.
How about Small Computer System Interface for example? Universal Serial
Bus and Serial Advanced Technology Attachment aren't much more colorful
either. Granted, their acronyms are prettier than HPSB, but not as
elitist. ;-)
-- 
Stefan Richter
-=====-=-==- ==-- -=-==
http://arcgraph.de/sr/
