Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbTIOWbh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 18:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbTIOWbh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 18:31:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:36515 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261642AbTIOWbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 18:31:36 -0400
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: davidsen@tmr.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       zwane@linuxpower.ca
In-Reply-To: <200309151934.h8FJYI84002544@81-2-122-30.bradfords.org.uk>
References: <200309151934.h8FJYI84002544@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063664888.8256.25.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Mon, 15 Sep 2003 23:28:09 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-15 at 20:34, John Bradford wrote:
> Yes, you're right, from a stability point of view I was being a bit
> impractical.  Any idea how many developers are actually regularly
> testing code on 386s these days, by the way?

I test 486 still but not 386. Even finding embedded 386 stuff that isnt
obsolete is hard nowdays (6117 etc). 

