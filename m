Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261719AbUKQRgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261719AbUKQRgh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUKQRfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:35:08 -0500
Received: from [213.85.13.118] ([213.85.13.118]:62338 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262427AbUKQRdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:33:55 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16795.35688.634029.21478@gargle.gargle.HOWL>
Date: Wed, 17 Nov 2004 20:33:28 +0300
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
In-Reply-To: <Pine.LNX.4.53.0411171809490.24190@yvahk01.tjqt.qr>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
	<Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
	<E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
	<84144f0204111602136a9bbded@mail.gmail.com>
	<E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
	<20041116120226.A27354@pauline.vellum.cz>
	<E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
	<20041116163314.GA6264@kroah.com>
	<E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
	<16795.33515.187015.492860@thebsh.namesys.com>
	<Pine.LNX.4.53.0411171809490.24190@yvahk01.tjqt.qr>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt writes:
 > 
 > >mount -tfoo_ctrlfs -o host=/mnt/point /mnt/control-point
 > 
 > Looks to me like a pollution of the mount table if you do this on a lot of
 > filesystems.
 > 

If you have a lot of file-systems your mount table is already polluted.

As they say, in UNIX everything is a file, and in Linux---a filesystem.

 > 
 > 
 > Jan Engelhardt
 > -- 

Nikita.
