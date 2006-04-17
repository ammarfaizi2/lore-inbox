Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWDQNZt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWDQNZt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWDQNZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:25:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:51755 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750854AbWDQNZs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:25:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ffRSefrhvP+l9d2cZHCiSyij81/1SujCbmv3tTxJrhVygDoUbMGC7NG1AyDrGvYEd7UUdHhwT6JnRwfPKP753HhojSgHf/VhRlMdo2Ox0ueD13T5GX5UtpfMIG6ujSWpTjuHREjB+IOgFFABb3iqP+ZKrB6EuuzhwG5oOMWKk6s=
Message-ID: <85e0e3140604170625k112680f8qd4ef96f7d3d3ea98@mail.gmail.com>
Date: Mon, 17 Apr 2006 18:55:48 +0530
From: Niklaus <niklaus@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Boot CDrom from grub
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I have a bootable CD and normal ISO9660 data CD (linux non-bootable)
, both has linux on it.
 I don't have the BIOS password and hence cannot change the bios
startup options.

1) Is there any way to boot the CD from grub command line ?

 2) Can i access the data in ISO9660 from grub command line ?

I can boot a floppy like root(fd0)
chainloader +1
boot

simlarly windows partition like root(hd0,2)
chainloader +1
boot

Is there anything for bootable CD .

How to access data in ISO CD . Can we do it like ext2 of harddisk.

Regards
Nik
