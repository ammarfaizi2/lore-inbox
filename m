Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266902AbUHITJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266902AbUHITJt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 15:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266900AbUHITIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 15:08:45 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:57232 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266910AbUHITIW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 15:08:22 -0400
Date: Mon, 9 Aug 2004 12:08:38 -0700
From: Paul Jackson <pj@sgi.com>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc3: vfat problem [was: Re: [Problem] 2.6.8-rc3:
 usb-storage devices are read-only (NOT related to iocharset)]
Message-Id: <20040809120838.1d5377d3.pj@sgi.com>
In-Reply-To: <200408092039.12606.rjwysocki@sisk.pl>
References: <200408082157.35469.rjwysocki@sisk.pl>
	<200408082208.02328.rjwysocki@sisk.pl>
	<20040809060359.5be7c11f.pj@sgi.com>
	<200408092039.12606.rjwysocki@sisk.pl>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen other messages fly by on lkml concerning the vfat the ro/rw,
code page, and such confusions you report.  The points you raise make
sense ... I haven't been paying close enough attention to explain
further.  I've just been happily using the remount,rw workaround ...

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
