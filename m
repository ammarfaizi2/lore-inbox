Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271702AbTHHRYb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271715AbTHHRYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 13:24:30 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:14985 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271702AbTHHRYa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 13:24:30 -0400
Subject: Re: Innovision EIO DM-8301H/R SATA cards...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308081511.28238.m.watts@eris.qinetiq.com>
References: <200308081408.16564.m.watts@eris.qinetiq.com>
	 <3F33A3EB.9030108@pobox.com>  <200308081511.28238.m.watts@eris.qinetiq.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060363207.4937.56.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Aug 2003 18:20:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-08-08 at 15:11, Mark Watts wrote:
> Great stuff - can someone confirm whether I still need to do the folloing for 
> the latest 2.4.22 kernels in order to get good performance?
> 
> # hdparm -d1 -X66 /dev/hdX
> # echo "max_kb_per_request:15" > /proc/.ide/hdX/settings

In -ac pretty much everything "just works". Just finishing off one or
two last issues

