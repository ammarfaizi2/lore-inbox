Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTI0XoC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 19:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTI0XoC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 19:44:02 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:52613 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S262283AbTI0Xn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 19:43:59 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200309272340.h8RNeu3h026201@wildsau.idv.uni.linz.at>
Subject: traffic shaper: help in Configuration wrong
To: linux-kernel@vger.kernel.org
Date: Sun, 28 Sep 2003 01:40:56 +0200 (MET DST)
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

in "Linux Kernel v2.4.22 Configuration", "Traffic Shaper (EXPERIMENTAL)",
the help-function displays the following text:

    To set up and configure shaper devices, you need the shapecfg           
    program, available from <ftp://shadow.cabi.net/pub/Linux/> in the      
    shaper package.   

However:

    $ host shadow.cabi.net
    Host shadow.cabi.net not found: 3(NXDOMAIN)

please put in correct address.

thanks,
h.rosmanith
