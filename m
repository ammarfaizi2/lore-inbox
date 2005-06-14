Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVFNRR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVFNRR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 13:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVFNRR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 13:17:59 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:30443 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S261260AbVFNRRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 13:17:48 -0400
Date: Wed, 15 Jun 2005 02:16:26 +0900 (JST)
Message-Id: <20050615.021626.42934687.okuyamak@dd.iij4u.or.jp>
To: erik@harddisk-recovery.com
Cc: reiser@namesys.com, adilger@clusterfs.com, fs@ercist.iscas.ac.cn,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       zhiming@admin.iscas.ac.cn, qufuping@ercist.iscas.ac.cn,
       madsys@ercist.iscas.ac.cn, xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, matsui_v@valinux.co.jp,
       kikuchi_v@valinux.co.jp, fernando@intellilink.co.jp,
       kskmori@intellilink.co.jp, takenakak@intellilink.co.jp,
       yamaguchi@intellilink.co.jp, ext2-devel@lists.sourceforge.net,
       shaggy@austin.ibm.com, xfs-masters@oss.sgi.com,
       Reiserfs-Dev@namesys.com
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel
 summit
From: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
In-Reply-To: <20050614125130.GA30812@harddisk-recovery.com>
References: <20050613201315.GC19319@moraine.clusterfs.com>
	<42AE1D4A.3030504@namesys.com>
	<20050614125130.GA30812@harddisk-recovery.com>
X-Mailer: Mew version 4.0.65 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Eric,

>>>>> "Eric" == Erik Mouw <erik@harddisk-recovery.com> writes:
Eric> I'd rather have a filesystem which I can tell to warn me immediately
Eric> about a problem and not make things worse by trying to continue.
Eric> A mount option for Reiserfs like Andreas proposed would be a good idea.

I 100% agree with you about how file system should act.

# STOP!! in the name....

best regards,
---- 
Kenichi Okuyama
