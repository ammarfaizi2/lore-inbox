Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319113AbSHMTro>; Tue, 13 Aug 2002 15:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHMTro>; Tue, 13 Aug 2002 15:47:44 -0400
Received: from web11308.mail.yahoo.com ([216.136.131.211]:35591 "HELO
	web11308.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S319113AbSHMTrn>; Tue, 13 Aug 2002 15:47:43 -0400
Message-ID: <20020813195135.57526.qmail@web11308.mail.yahoo.com>
Date: Tue, 13 Aug 2002 12:51:35 -0700 (PDT)
From: Alex Deucher <agd5f@yahoo.com>
Subject: advansys ABP-460 support
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone know that status of support for the advansys ABP-460 pcmcia
scsi chip?  Since advansys was aquired by initio, I can't seem to find
much info on any of their chips.  From what I've gathered from the web
and usenet, I think the ABP-460 may correlate to the ASC3350p.  The
ABP-480 which seems to be a cardbus version of the 460 seems to be
supported by the advansys.c driver seems to correlate to the ASC3350c;
at least as far as I can tell from the windows drivers.  I found some
open source linux drivers from Ratoc
(http://www.ratocsystems.com/english/index.html) that support some
Advansys cardbus chips, but I can't tell which ones, as it seems
somewhat specific to their own OEM cards.  Could someone out there that
knows this stuff better shed some light on this?  It seems to me that
it would be reletively easy to add support for th ABP-460 since that
ABP-480 is already supported and I'd imagine the 460 is similar to some
ISA or PCI version of the chip, much like what is done in the aha15xx
and aic78xx drivers.

Thanks,

Alex

PS.  please cc me on any responses as I'm not subscribed to the list.

__________________________________________________
Do You Yahoo!?
HotJobs - Search Thousands of New Jobs
http://www.hotjobs.com
