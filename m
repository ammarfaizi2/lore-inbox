Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264127AbTIIPGD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 11:06:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTIIPGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 11:06:03 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:24943 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S264127AbTIIPF7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 11:05:59 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: keithl@ieee.org, Keith Lofstrom <keithl@kl-ic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Hot Swapping IDE using USB2 cage
Date: Tue, 9 Sep 2003 16:01:01 +0100
User-Agent: KMail/1.5
References: <20030908193207.GA29053@gate.kl-ic.com>
In-Reply-To: <20030908193207.GA29053@gate.kl-ic.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200309091601.01731.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> A month back, there was discussion about hotswapping IDE disks.
> I have a solution that seems to work, indirectly, using the SanMax
> InClose PMD96-USB2 Mobile Dock.  This cage is physically compatable
> with the PMD96i direct IDE cages, but has a translator from IDE
> (LBA48!) to USB2, which I connect to a USB2 PCI card in my system.
> With USB hotswap enabled,  the system seems to recognize when
> disks are added and removed.  This allows me to do backups to
> cheap big IDE hard drives, and swap them out for safekeeping.
> For more information, look at my web page in progress:
>
>    http://www.keithl.com/linuxbackup.html
>
> I am still working on this, so your mileage may vary.  I am
> incompetent at software, so a more clueful person is welcome
> to take over and do this right.  In any case, this provides a
> functional solution for IDE hotswap without kernel patches, and
> that might free up some wizard time for other needed tasks.
>
> Keith

This isn't IDE hotswap, its USB hotswap with USB Mass-Storage devices.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/XestBn4EFUVUIO0RAkUDAJwKZFVCVRMgfiqAvHodFKHkV+fCfACeOCMO
/rAEWJkRoogVkb+k3ebZ92Y=
=teqy
-----END PGP SIGNATURE-----

