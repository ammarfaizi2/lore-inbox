Return-Path: <linux-kernel-owner+w=401wt.eu-S1030302AbWL3TLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWL3TLP (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 14:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWL3TLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 14:11:15 -0500
Received: from p02c11o141.mxlogic.net ([208.65.145.64]:45095 "EHLO
	p02c11o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030302AbWL3TLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 14:11:14 -0500
Date: Sat, 30 Dec 2006 21:11:23 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-sound@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
       PeiSen Hou <pshou@realtek.com.tw>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Message-ID: <20061230191123.GA4352@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <200612301844.02413.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612301844.02413.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2006 19:13:18.0968 (UTC) FILETIME=[90A90F80:01C72C46]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--9.429300-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 29 December 2006 06:25, Michael S. Tsirkin wrote:
> > Virtual MIDI Card 1
> 
> Compile this feature out, I bet things start working again.

Yes, this helped, thanks.
BTW, is this expected?


-- 
MST
