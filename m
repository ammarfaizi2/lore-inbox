Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287244AbSBCMrp>; Sun, 3 Feb 2002 07:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287045AbSBCMrf>; Sun, 3 Feb 2002 07:47:35 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:42991 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S287048AbSBCMrW>; Sun, 3 Feb 2002 07:47:22 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020203123329.GA14350@tapu.f00f.org> 
In-Reply-To: <20020203123329.GA14350@tapu.f00f.org>  <20020203091345.GA11207@tapu.f00f.org> <E16WQYs-0003Ux-00@the-village.bc.nu> <m17kpv8amu.fsf@frodo.biederman.org> <20020203080134.C19813@dea.linux-mips.net> <13070.1012738560@redhat.com> 
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Feb 2002 12:47:20 +0000
Message-ID: <13785.1012740440@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


cw@f00f.org said:
>  Obviously it still has flash... but much of the filesystem is ramfs
> and thus ram is rather precious.

Ah, I see. What are you doing with it? Mine hardly touches the ramfs.

sh-2.03# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/mtdblock/2          32256     26908      5348  84% /
tmpfs                    15428       260     15168   2% /mnt/ramfs


--
dwmw2


