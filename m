Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277519AbRJJXDp>; Wed, 10 Oct 2001 19:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277526AbRJJXD1>; Wed, 10 Oct 2001 19:03:27 -0400
Received: from cx48762-b.cv1.sdca.home.com ([24.251.153.196]:45606 "EHLO
	train.sweet-haven.com") by vger.kernel.org with ESMTP
	id <S277519AbRJJXDW>; Wed, 10 Oct 2001 19:03:22 -0400
Date: Wed, 10 Oct 2001 16:03:48 -0700 (PDT)
From: Lew Wolfgang <wolfgang@sweet-haven.com>
To: <linux-kernel@vger.kernel.org>
Subject: Dump corrupts ext2?
Message-ID: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

I was looking for some scripts to backup ext2 partitions
to multiple CDR's when I stumbled onto "cdbackup" at
http://www.cableone.net/ccondit/cdbackup/.

Alas, there is a warning saying:

"WARNING! When using this program under Linux, be sure not to use
 dump with kernels in the 2.4.x series. Using dump on an ext2
 filesystem has a very high potential for causing filesystem
 corruption.  As of kernel version 2.4.5, this has not been
 resolved, and it may not be for some time."

I don't recall any problems like this, does anyone have
additional comments?

Regards,
Lew Wolfgang


