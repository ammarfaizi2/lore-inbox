Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315634AbSHMPEK>; Tue, 13 Aug 2002 11:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSHMPEK>; Tue, 13 Aug 2002 11:04:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24056 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315634AbSHMPEK>; Tue, 13 Aug 2002 11:04:10 -0400
Subject: Re: searching for dell 2650 PERC3-DI driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bourne <jbourne@mtroyal.ab.ca>
Cc: Tom Sightler <ttsig@tuxyturvy.com>, Ingo Molnar <mingo@elte.hu>,
       Jeff Chua <jeffchua@silk.corp.fedex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0208130749110.23949-100000@skuld.mtroyal.ab.ca>
References: <Pine.LNX.4.44.0208130749110.23949-100000@skuld.mtroyal.ab.ca>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 13 Aug 2002 16:04:25 +0100
Message-Id: <1029251065.21007.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-13 at 15:02, James Bourne wrote:
> If it's a PERC3-DI, then the raid driver is the aacraid as this is the
> ROMB raid, basically a firmware addon to the adaptec scsi on board (IIRC).


The aacraid has two forms, one driving the on board devices, the other
which is stuff like the Obsidian (PERC2/QC) PCI card. Its a nice bit of
hardware, although the older i960 based ones are a bit slow.


