Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTDEV4R (for <rfc822;willy@w.ods.org>); Sat, 5 Apr 2003 16:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262684AbTDEV4R (for <rfc822;linux-kernel-outgoing>); Sat, 5 Apr 2003 16:56:17 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:19601 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262683AbTDEV4Q (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 5 Apr 2003 16:56:16 -0500
Date: Sun, 6 Apr 2003 00:07:55 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: error building MTD modules in 2.5.66-bk10
Message-ID: <20030405220755.GA9262@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0304041727460.7451-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304041727460.7451-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 April 2003 17:28:37 -0500, Robert P. J. Day wrote:
> drivers/mtd/devices/blkmtd.c:52:25: linux/iobuf.h: No such file or directory

blkmtd is known broken. Try the read-modify-write one instead.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu
