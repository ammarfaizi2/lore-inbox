Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbTICSg6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbTICSgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:36:14 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:11213 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264282AbTICSeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:34:06 -0400
Subject: Re: Scaling noise
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Larry McVoy <lm@work.bitmover.com>, "Brown, Len" <len.brown@intel.com>,
       Giuliano Pochini <pochini@shiny.it>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030903181550.GR4306@holomorphy.com>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCEB@hdsmsx402.hd.intel.com>
	 <20030903111934.GF10257@work.bitmover.com>
	 <20030903180037.GP4306@holomorphy.com>
	 <20030903180547.GD5769@work.bitmover.com>
	 <20030903181550.GR4306@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062613931.19982.26.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 19:32:12 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-03 at 19:15, William Lee Irwin III wrote:
> Independent operating system instances running under a hypervisor don't
> qualify as a cache-coherent cluster that I can tell; it's merely dynamic
> partitioning, which is great, but nothing to do with clustering or SMP.

Now add a clusterfs and tell me the difference, other than there being a
lot less sharing going on...

