Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136003AbRDVJpa>; Sun, 22 Apr 2001 05:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136004AbRDVJpV>; Sun, 22 Apr 2001 05:45:21 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:60429 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S136003AbRDVJpM>; Sun, 22 Apr 2001 05:45:12 -0400
Message-ID: <3AE2A827.4A2E5380@egu.schule.ulm.de>
Date: Sun, 22 Apr 2001 11:45:11 +0200
From: Steffen Moser <moser@egu.schule.ulm.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Werner Hager <antheus@gmx.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2+3 dies on Epox Athlon Board with Sig11
In-Reply-To: <30729.987895384@www30.gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Werner Hager wrote:

> I  have here an epox athlon slotA via board which refuses 2.4.
> On Redhat 7.0 kernel 2.4.2 (or was it 2.4.1?)  made the system slow (fsck
> the 2GB disc took around an hour). 

Have you tried to disable "Power Management" (especially "ACPI support")
in your kernel configuration? Does that solve your problem? Have you
tried "linux-2.4.3", yet?

HTH!

Best regards,
Steffen
