Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272268AbTGYSHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 14:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTGYSHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 14:07:03 -0400
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:50357
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S272268AbTGYSG6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 14:06:58 -0400
Message-ID: <3F2177DF.3040005@rogers.com>
Date: Fri, 25 Jul 2003 14:33:03 -0400
From: gaxt <gaxt@rogers.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030708 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Ruvolo <chris+lkml@ruvolo.net>
CC: Torrey Hoffman <thoffman@arnor.net>, Ben Collins <bcollins@debian.org>,
       Sam Bromley <sbromley@cogeco.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: Firewire
References: <1059103424.24427.108.camel@daedalus.samhome.net> <20030725041234.GX1512@phunnypharm.org> <20030725053920.GH23196@ruvolo.net> <20030725133438.GZ1512@phunnypharm.org> <20030725142907.GI23196@ruvolo.net> <20030725142926.GD1512@phunnypharm.org> <20030725154009.GF1512@phunnypharm.org> <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org> <1059155483.2525.16.camel@torrey.et.myrio.com> <20030725181303.GO23196@ruvolo.net>
In-Reply-To: <20030725181303.GO23196@ruvolo.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.157.78.60] using ID <dw2price@rogers.com> at Fri, 25 Jul 2003 14:22:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For what it's worth to anyone:

root@localhost linux # lspci -v -s00:0f.0
00:0f.0 FireWire (IEEE 1394): Texas Instruments FireWire Controller (rev 
01) (prog-if 10 [OHCI])
         Subsystem: Ads Technologies Inc: Unknown device 0000
         Flags: bus master, medium devsel, latency 64, IRQ 5
         Memory at cfffc800 (32-bit, non-prefetchable) [size=2K]
         Memory at cfff8000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [44] Power Management version 1

