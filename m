Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263993AbRFHNoZ>; Fri, 8 Jun 2001 09:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263995AbRFHNoP>; Fri, 8 Jun 2001 09:44:15 -0400
Received: from mgw-x3.nokia.com ([131.228.20.26]:41113 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S263993AbRFHNoF>;
	Fri, 8 Jun 2001 09:44:05 -0400
Date: Fri, 8 Jun 2001 16:42:54 +0300
To: linux-kernel@vger.kernel.org
Subject: VFS bug? Trying to free free buffer
Message-ID: <20010608164254.A936@Hews1193nrc>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: alexey.vyskubov@nokia.com (Alexey Vyskubov)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Kernel 2.4.5.

$ sudo mount -o iocharset=garbage /dev/cdrom /cdrom

VFS: brelse: Trying to free free buffer

-- 
Alexey
