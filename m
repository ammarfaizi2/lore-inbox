Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271243AbUJVLcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271243AbUJVLcp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271241AbUJVLcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:32:45 -0400
Received: from lucidpixels.com ([66.45.37.187]:48768 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id S271222AbUJVL3r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:29:47 -0400
Date: Fri, 22 Oct 2004 07:29:46 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p500
To: linux-kernel@vger.kernel.org
cc: apiszcz@lucidpixels.com
Subject: Kernel 2.6.x: nfs warning: mount version older than kernel
Message-ID: <Pine.LNX.4.61.0410220727120.514@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# mount -a
# dmesg | tail -n 5
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
# mount --version
mount: mount-2.12h
#

I am using the latest util-linux from the developers site, so I am 
curious, why do I get this warning in dmesg/ring-buffer?

# ftp://ftp.win.tue.nl/pub/linux-local/utils/util-linux/
