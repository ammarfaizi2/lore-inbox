Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290634AbSBLAVV>; Mon, 11 Feb 2002 19:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290635AbSBLAVL>; Mon, 11 Feb 2002 19:21:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:42758 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S290634AbSBLAU5>; Mon, 11 Feb 2002 19:20:57 -0500
Subject: Re: Linux 2.4.18-pre9-ac1
To: andersen@codepoet.org
Date: Tue, 12 Feb 2002 00:34:33 +0000 (GMT)
Cc: alan@redhat.com (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20020212001547.GA22586@codepoet.org> from "Erik Andersen" at Feb 11, 2002 05:15:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16aQu1-00008C-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I notice that in linux/drivers/scsi/scsi_merge.c you seem to
> be reverting the MO drive clustering fix from Jens:
>     http://www.uwsg.indiana.edu/hypermail/linux/kernel/0202.0/1321.html
> 
> Was this intentional?  If so, why?

I want to find out why it was done first and then test it. Leaving it out
will ensure it bugs me until I test it

