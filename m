Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264620AbTAJIZ1>; Fri, 10 Jan 2003 03:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264631AbTAJIZ1>; Fri, 10 Jan 2003 03:25:27 -0500
Received: from ns.suse.de ([213.95.15.193]:48402 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S264620AbTAJIZ0>;
	Fri, 10 Jan 2003 03:25:26 -0500
Date: Fri, 10 Jan 2003 09:34:10 +0100
From: Hubert Mantel <mantel@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: UnitedLinux violating GPL?
Message-ID: <20030110083409.GH30114@suse.de>
References: <20030109222748.GA3993@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030109222748.GA3993@gtf.org>
Organization: SuSE Linux AG, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.19-4GB
X-GPG-Key: 1024D/B0DFF780
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 09, Jeff Garzik wrote:

> Anybody know where the source rpm for UnitedLinux kernel is?
> [to be distinguished from kernel-source rpm]

Sure, it's here:

ftp.suse.com:/pub/unitedlinux/1.0/src/kernel-source-2.4.19.SuSE-82.nosrc.rpm

This RPM contains the individual patches as well as the specfile to create 
the kernel-source.rpm. It's only missing the vanilla kernel source tarball 
in order to save space (this tarball is available on every other ftp 
server in the internet anyway).

For creation of the individual binary kernel RPMs you need the following 
source RPMs which are of course also available:

-rw-r--r--    1 root     root        18972 Oct 21 21:45 k_athlon-2.4.19-111.src.rpm
-rw-r--r--    1 root     root       168055 Oct 21 22:28 k_debug-2.4.19-79.src.rpm
-rw-r--r--    1 root     root       186467 Oct 21 22:04 k_deflt-2.4.19-120.src.rpm
-rw-r--r--    1 root     root       178477 Oct 21 22:04 k_psmp-2.4.19-115.src.rpm
-rw-r--r--    1 root     root       185329 Oct 21 22:21 k_smp-2.4.19-113.src.rpm

> AFAICS they are not distributing source code to their published kernel
> binaries...  which is a very obvious GPL violation.

Any chance you could check the facts before accusing people publically?

> I'm also surprised the even-more-pro-GPL-than-me people have not jumped
> on UnitedLinux for not distributing source code.

Because they are probably not too lazy to check the facts before offending 
people.

> 	Jeff, looking for useful [rumored] drivers/net patches
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
