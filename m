Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbTBIPBQ>; Sun, 9 Feb 2003 10:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267278AbTBIPBQ>; Sun, 9 Feb 2003 10:01:16 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:42002 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S267277AbTBIPBP>; Sun, 9 Feb 2003 10:01:15 -0500
Date: Sun, 9 Feb 2003 10:10:59 -0500
From: Ben Collins <bcollins@debian.org>
To: MaxF <maxer1@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire Buslink dirve incorrectly detected as a LiteOn in 2.4.20
Message-ID: <20030209151059.GM2522@phunnypharm.org>
References: <3E466E84.3060907@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E466E84.3060907@xmission.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 08:06:44AM -0700, MaxF wrote:
> All kernels post 2.4.20-xx are detecting my firewire Buslink CD-RW
> as:
> 
> Feb  9 07:54:19 maxer kernel:   Vendor: LITE-ON   Model: 
> LTR-48125W        Rev: VS06
> 
> Buslink model #RW4848FE
> 
> I do have however a second drive that is a Lite-On, but is not firewire.

Can you give some more details, like a complete description of your
system configuration including this other drive that appears to tbe
confusing the scsi layer.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
