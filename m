Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132757AbRC2PsM>; Thu, 29 Mar 2001 10:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132756AbRC2PsC>; Thu, 29 Mar 2001 10:48:02 -0500
Received: from [194.25.18.216] ([194.25.18.216]:44813 "EHLO ntovmsw02.otto.de")
	by vger.kernel.org with ESMTP id <S132755AbRC2Prr> convert rfc822-to-8bit;
	Thu, 29 Mar 2001 10:47:47 -0500
Message-Id: <4B6025B1ABF9D211B5860008C75D57CC0271B9E1@NTOVMAIL04>
From: "Butter, Frank" <Frank.Butter@otto.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: WG: 2.4 on COMPQ Proliant
Date: Thu, 29 Mar 2001 17:47:39 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.2.16 claimes to find a ncr53c1510D-chipset, supported by
the driver ncr53c8xx. Which kernel-param would be the correct one for this?

Frank

> -----Ursprüngliche Nachricht-----
> Von: Butter, Frank 
> Gesendet: Donnerstag, 29. März 2001 17:11
> An: 'linux-kernel@vger.kernel.org'
> Betreff: 2.4 on COMPQ Proliant
> 
> 
> 
> Has anyone experiences with 2.4.x on recent Compaq Proliant 
> Servers (e.g. ML570)?
> 
> I've installed RedHat7 and it worked fine out of the box.
> Except that the SMP-enabled kernel stated there was no 
> SMP-board detected ;-/
> For some reasons (Fibrechannel drivers and so on) I've compiled
> 2.4.2 and installed it. Although I've compiled the support 
> in, the NCR-SCSI-chip was not found and therefore no 
> root-partition. It is a model supported by 53c8xx - detected 
> by the original RedHat-kernel.  
> 
> For testing I compiled a kernel with all (!) scsi-low-level-drivers -
> with the same result. The SMP-board also was NOT detected by 2.4.2.
> 
> Any hint?
> 
> Frank
> 
