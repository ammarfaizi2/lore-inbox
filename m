Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272215AbTHNFU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272216AbTHNFU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:20:27 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2944 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S272215AbTHNFU0 (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:20:26 -0400
Date: Thu, 14 Aug 2003 06:28:19 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200308140528.h7E5SJtZ000321@81-2-122-30.bradfords.org.uk>
To: bunk@fs.tum.de, john@grabjohn.com
Subject: Re: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Cc: davidsen@tmr.com, jgarzik@pobox.com, Linux-Kernel@vger.kernel.org,
       Riley@Williams.Name, szepe@pinerecords.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the user is ignorant to the point that an error message whilst
compiling a development kernel, (I.E. any kernel from kernel.org),
would cause them to think:

>   Look, what a crap Linux is, the developers even care whether the 
>   kernel compiles.

they are forming an opinion of Linux based on things they don't
understand.  That's ignorance, and CONFIG_BROKEN won't fix that.

John.
