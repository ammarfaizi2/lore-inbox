Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135437AbRDMIJb>; Fri, 13 Apr 2001 04:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135438AbRDMIJM>; Fri, 13 Apr 2001 04:09:12 -0400
Received: from big-relay-1.ftel.co.uk ([192.65.220.123]:35047 "EHLO
	old-callisto.ftel.co.uk") by vger.kernel.org with ESMTP
	id <S135437AbRDMIJK>; Fri, 13 Apr 2001 04:09:10 -0400
Message-ID: <3AD6B422.EEC092F0@ftel.co.uk>
Date: Fri, 13 Apr 2001 09:09:06 +0100
From: Paul Flinders <P.Flinders@ftel.co.uk>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.3-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <Pine.LNX.4.10.10104122052210.4564-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>
> Sorry, but http://www.linux-ide.org/ clearly states that nothing below a
> given line supports hardware/bios-soft raid.

Promise are clearly being less than helpful here and that is not your fault.

However as far as I can see everyone who has a FastTrak which is "stuck"
in RAID mode[1] would be happy if it worked as a normal IDE controller
in Linux, which is (usually?) not the case - eg on the MSI board where
only the first channel is seen.

[1] generally because it is integrated with the motherboard and RAID
is the only thing that the BIOS understands

