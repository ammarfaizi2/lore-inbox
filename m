Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130152AbRBUWZi>; Wed, 21 Feb 2001 17:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRBUWZ2>; Wed, 21 Feb 2001 17:25:28 -0500
Received: from gear.torque.net ([204.138.244.1]:29965 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S130174AbRBUWZM>;
	Wed, 21 Feb 2001 17:25:12 -0500
Message-ID: <3A943EDE.1C249E5F@torque.net>
Date: Wed, 21 Feb 2001 17:19:10 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: hiren_mehta@agilent.com, linux-scsi@vger.kernel.org
Subject: Re: downloading drive firmware to a fibre channel drive through linux
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hiren_mehta@agilent.com wrote:
> Is it possible to download a drive firmware to a fibre channel
> drive (or even a scsi drive) through linux ? I know that on
> NT (or 98) they use WNASPI and a utility provided by the 
> drive manufacturer to download the firmware. I was wondering
> if this is possible through linux scsi interface. For FC,
> I have Qlogic Fibre Channel card.

Yes. It is one of the advertised features of the Scsi Command
Utility (scu). There is a Linux port. See:
http://www.bit-net.com/~rmiller/scu.html

Doug Gilbert
