Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269998AbRHET1V>; Sun, 5 Aug 2001 15:27:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269997AbRHET1K>; Sun, 5 Aug 2001 15:27:10 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:20235 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S269996AbRHET1C>; Sun, 5 Aug 2001 15:27:02 -0400
Date: 05 Aug 2001 11:29:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <86HgALWHw-B@khms.westfalen.de>
In-Reply-To: <22165.996722560@kao2.melbourne.sgi.com>
Subject: PPC? (Was: Re: [RFC] /proc/ksyms change for IA64)
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <22165.996722560@kao2.melbourne.sgi.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kaos@ocs.com.au (Keith Owens)  wrote on 02.08.01 in <22165.996722560@kao2.melbourne.sgi.com>:

> The IA64 use of descriptors for function pointers has bitten ksymoops.
> For those not familiar with IA64, &func points to a descriptor
> containing { &code, &data_context }.

That sounds suspiciously like what I remember from PPC. How is this solved  
on the PPC side?

MfG Kai
