Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276418AbRI2CiP>; Fri, 28 Sep 2001 22:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276419AbRI2CiF>; Fri, 28 Sep 2001 22:38:05 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:29202 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S276418AbRI2Ch6>;
	Fri, 28 Sep 2001 22:37:58 -0400
Message-ID: <3BB53460.9000409@si.rr.com>
Date: Fri, 28 Sep 2001 22:39:28 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: 2.4.9-ac17: unresolved symbols
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
    I received the following while 'make modules_install'
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9-ac17/kernel/fs/cramfs/cramfs/cramfs.o
depmod:  zlib_fs_inflateInit_
depmod:  zlib_fs_inflateEnd
depmod:  zlib_fs_inflate_workspacesize
depmod:  zlib_fs_inflate
depmod:  zlib_fs_inflateReset

Used the same config that worked with 2.4.9-ac16 . Using gcc 
2.91.66..Upgrading to 2.95.4 soon.

Regards,
Frank

