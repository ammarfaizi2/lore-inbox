Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTE0MrS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 08:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263458AbTE0MrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 08:47:17 -0400
Received: from [62.29.65.179] ([62.29.65.179]:22146 "EHLO submoron.org")
	by vger.kernel.org with ESMTP id S263449AbTE0MrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 08:47:17 -0400
From: "ismail (cartman) donmez" <kde@myrealbox.com>
Organization: Bogazici University
To: "Simon Kofod" <skofod@operamail.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Can't mount a SCSI emulated IDE cd-rom
Date: Tue, 27 May 2003 15:59:36 +0300
User-Agent: KMail/1.5.9
References: <20030527104652.23033.qmail@operamail.com>
In-Reply-To: <20030527104652.23033.qmail@operamail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
   =?ISO-8859-1?Q?=20charset=3D=22=FDso-885?= =?ISO-8859-1?Q?9-9=22?=
Content-Transfer-Encoding: 7bit
Message-Id: <200305271559.36825.kde@myrealbox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 13:46, Simon Kofod wrote:
> Hi,
> I will try to follow the suggested procedure for reporting kernel bugs
> (http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html).
>
> 1) I can't mount a SCSI emulated IDE cd-rom.
>
> 2) When trying to mount the cdrom it writes the error:
> "mount: wrong fs type, bad option, bad superblock on /dev/sr0, or too many
> mounted file systems"

You got scsi tape support in kernel ? And are you mounting like
mount /dev/scdX /mnt/somewhere where X is 0,1,2.... ?

Best Regards,
/ismail donmez
