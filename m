Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264573AbUEDSz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264573AbUEDSz1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUEDSz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:55:27 -0400
Received: from cernmx05.cern.ch ([137.138.166.161]:59974 "EHLO
	cernmx05.cern.ch") by vger.kernel.org with ESMTP id S264573AbUEDSzX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:55:23 -0400
Keywords: CERN SpamKiller Note: -52 Charset: west-latin
X-Filter: CERNMX05 SMTPGW CERN Spam Sink v1.0
From: Alexander ZVYAGIN <Alexander.Zviagine@cern.ch>
To: Greg KH <greg@kroah.com>
Subject: Re: Problems with USB/Sound.
Date: Tue, 4 May 2004 20:55:20 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, linux-usb-users@lists.sourceforge.net
References: <200405041135.55950.Alexander.Zviagine@cern.ch> <20040504162252.GC20453@kroah.com>
In-Reply-To: <20040504162252.GC20453@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405042055.20946.Alexander.Zviagine@cern.ch>
X-OriginalArrivalTime: 04 May 2004 18:55:21.0787 (UTC) FILETIME=[59EAC8B0:01C43209]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 May 2004 18:22, Greg KH wrote:
> On Tue, May 04, 2004 at 11:35:55AM +0200, Alexander ZVYAGIN wrote:
> > Hello,
> >
> > It seems that linux  2.6.5 has some problems with my USB ports...
> > See config-1, dmesg-1.
> >
> > Whatever I connect to the USB ports, I see no reaction at all.
>
> Care to file a bug at bugzilla.kernel.org for this?

The bug report is there:
http://bugme.osdl.org/show_bug.cgi?id=2637

I am not a kernel hacker, so if somebody tell me how to debug/fix the kernel, 
that would be nice...

Alexander.
