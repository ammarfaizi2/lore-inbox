Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131448AbRCQMny>; Sat, 17 Mar 2001 07:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131619AbRCQMno>; Sat, 17 Mar 2001 07:43:44 -0500
Received: from smtp02.wxs.nl ([195.121.6.54]:61911 "EHLO smtp02.wxs.nl")
	by vger.kernel.org with ESMTP id <S131448AbRCQMnf>;
	Sat, 17 Mar 2001 07:43:35 -0500
Message-ID: <3AB35BE8.2E0EC8FA@planet.nl>
Date: Sat, 17 Mar 2001 13:43:20 +0100
From: Erik van Asselt <e.van.asselt@planet.nl>
X-Mailer: Mozilla 4.7 [nl] (Win98; U)
X-Accept-Language: nl
MIME-Version: 1.0
To: Douglas Gilbert <dgilbert@interlog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: problems compiling scsi_ioctl on kernels later 2.4.1
In-Reply-To: <3AB2F378.10D22DA5@interlog.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did link the usr/include/scsi to usr/srs/linux/include/scsi
isn't that the right way for compiling the new kernel?

Erik

Douglas Gilbert schreef:

> Erik,
> It looks like you are missing (or have a corrupted)
> include/scsi/scsi_ioctl.h header file. It contains
> the definition of the struct Scsi_Ioctl_Command .
>
> Doug Gilbert

