Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281836AbRLRMuQ>; Tue, 18 Dec 2001 07:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281818AbRLRMuG>; Tue, 18 Dec 2001 07:50:06 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:51617 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S281836AbRLRMty>; Tue, 18 Dec 2001 07:49:54 -0500
Message-ID: <3C1F3AC3.7070109@antefacto.com>
Date: Tue, 18 Dec 2001 12:46:59 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mike Castle <dalgoda@ix.netcom.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: ramdisk size clarification
In-Reply-To: <3C1E587C.9060300@antefacto.com> <20011217211429.GA8826@thune.mrc-home.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Castle wrote:

> On Mon, Dec 17, 2001 at 08:41:32PM +0000, Padraig Brady wrote:
> 
>>and also there is no upper limit on the amount of RAM used,
>>so the following will kill your system (well it did for me):
>>dd if=/dev/zero of=/dev/ram0
>>
> 
> Bug in recent 2.4.*.  It *should* stop.  One line patch has been
> posted to the linux-kernel list a couple of times.  Check the archive.
> It's probably in the recent pre-release kernels as well.
> 

Great thanks!
http://marc.theaimsgroup.com/?l=linux-kernel&m=100797607432139&w=2

Padraig.

