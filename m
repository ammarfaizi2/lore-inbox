Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbSKGC2M>; Wed, 6 Nov 2002 21:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266293AbSKGC2M>; Wed, 6 Nov 2002 21:28:12 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:44280 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S266292AbSKGC2L>; Wed, 6 Nov 2002 21:28:11 -0500
Message-ID: <3DC9D145.6040109@attbi.com>
Date: Wed, 06 Nov 2002 18:34:45 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021022
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EXT2 corruption -- After running 2.5.46, my root partition cannot
 be mounted by older kernels
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am not sure how to diagnose the problem.  When I try to boot
the latest RH 8.0 kernel, I am informed that some unsupported
extensions are present on /dev/hda12 at boot time.  The partition
fails to mount and the boot process halts.

I have no trouble booting with 2.5.46.

    Miles

