Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbTF0SW0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbTF0SW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:22:26 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:41449 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264653AbTF0SWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:22:22 -0400
Date: Fri, 27 Jun 2003 20:36:33 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-ac4
Message-ID: <20030627183633.GD21564@louise.pinerecords.com>
References: <200306271811.h5RIBvX05325@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306271811.h5RIBvX05325@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@redhat.com]
> 
> Hopefully this gets stuff back nice and stable. I'll start pushing stuff
> to Marcelo soon and resync with 2.4.22pre

$ ncftpget ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.21/patch-2.4.21-ac3.gz
patch-2.4.21-ac3.gz:                                     2.76 MB  287.98 kB/s
$ ncftpget ftp://ftp.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.21/patch-2.4.21-ac4.gz
patch-2.4.21-ac4.gz:                                     2.76 MB  293.25 kB/s  
$ ls -la patch-2.4.21-ac[34].gz
-rw-r--r--    1 kala     users     2891908 Jun 25 18:32 patch-2.4.21-ac3.gz
-rw-r--r--    1 kala     users     2891908 Jun 27 20:07 patch-2.4.21-ac4.gz
$ diff patch-2.4.21-ac[34].gz
$

hrm0ps
