Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267086AbSKWXBH>; Sat, 23 Nov 2002 18:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbSKWXBH>; Sat, 23 Nov 2002 18:01:07 -0500
Received: from mnh-1-18.mv.com ([207.22.10.50]:18181 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S267086AbSKWXBH>;
	Sat, 23 Nov 2002 18:01:07 -0500
Message-Id: <200211232312.SAA02257@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@sourceforge.net
Subject: [uml-devel] uml-patch-2.5.48-1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Nov 2002 18:12:14 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges the network changes from my 2.4 pool.
        the network drivers react better to errors
        there is now a slirp backend
        the code that's common to the slip and slirp backends is shared
        cleaned up device initialization
        applied a bunch of slip cleanups and fixes

I also merged the network-specific help into the config.

The patch is available at
        http://uml-pub.ists.dartmouth.edu/uml/uml-patch-2.5.48-1.bz2
 
For the other UML mirrors and other downloads, see 
        http://user-mode-linux.sourceforge.net/dl-sf.html
 
Other links of interest:
 
        The UML project home page : http://user-mode-linux.sourceforge.net
        The UML Community site : http://usermodelinux.org
 
                                Jeff

