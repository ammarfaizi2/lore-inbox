Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWHQHBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWHQHBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 03:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWHQHBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 03:01:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32419 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932089AbWHQHBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 03:01:38 -0400
Subject: Re: PATCH: Multiprobe sanitizer
From: Arjan van de Ven <arjan@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155797833.11312.160.camel@localhost.localdomain>
References: <1155746538.24077.371.camel@localhost.localdomain>
	 <20060816222633.GA6829@kroah.com>
	 <1155774994.15195.12.camel@localhost.localdomain>
	 <1155797833.11312.160.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 09:00:57 +0200
Message-Id: <1155798057.4494.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> In fact, I'm all about making the problem worse by agressively
> paralellilizing everything to get distros config mecanisms to catch up
> and stop using the interface name (or use ifrename).

distros do this already based on MAC address ;)
at least some do.

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

