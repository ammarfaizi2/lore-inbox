Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265951AbUAEWBv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUAEWBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:01:50 -0500
Received: from aun.it.uu.se ([130.238.12.36]:54001 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265951AbUAEWBs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:01:48 -0500
Date: Mon, 5 Jan 2004 23:01:43 +0100 (MET)
Message-Id: <200401052201.i05M1her002460@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: wrlk@riede.org
Subject: Re: The survival of ide-scsi in 2.6.x
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Dec 2003 08:07:28 -0500, Willem Riede wrote:
>> Based on my expirience with ide-tape, I would rather have it
>> killed instead. One neat trick to appease enemies of ide-scsi
>> might be to rename it into ide-scsi into ide-tape-bis.
>> Might even add DSC bit handling... But the ide-tape is too
>> ugly to live for sure.
>
>I would agree, but would that get any people in trouble? That is,
>are there any IDE tape drives currently supported by ide-tape, 
>that are not compatble with ide-scsi plus st?

My Seagate STT8000A works better with ide-scsi+st than with ide-tape.
As long as a working ide-scsi is around, I couldn't care less about
the ide-tape abomination.

/Mikael
