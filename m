Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266942AbUAXOhD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 09:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266943AbUAXOhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 09:37:03 -0500
Received: from post1.dk ([62.242.36.44]:48651 "EHLO post1.dk")
	by vger.kernel.org with ESMTP id S266942AbUAXOhB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 09:37:01 -0500
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
To: Serge Belyshev <33554432@mtu-net.ru>
Subject: Re: [PATCH] arch/i386/Makefile,scripts/gcc-version.sh,Makefile
    small fixes
From: sam@ravnborg.org
Reply-To: sam@ravnborg.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain; charset=iso-8859-1
X-Mailer: acmemail <URL:http://www.astray.com/acmemail/>
Message-Id: <20040124143700.95AC215C24@post1.dk>
Date: Sat, 24 Jan 2004 15:37:00 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Date: 24 Jan 2004 17:04:54 +0300 skrev Serge Belyshev <33554432@mtu-net.ru> : 

>[This patch is against 2.6.2-rc1-mm2]
>
>arch/i386/Makefile:
>*  omitted $(KBUILD_SRC)/ in script call.

This should be $(srctree).

  Sam
