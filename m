Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275300AbTHMSAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275310AbTHMSAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:00:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16561 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S275300AbTHMR7C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:59:02 -0400
Message-ID: <3F3A7C59.7080703@pobox.com>
Date: Wed, 13 Aug 2003 13:58:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Matthew Wilcox <willy@debian.org>
CC: Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
References: <3F397FFB.9090601@pobox.com> <20030812171407.09f31455.rddunlap@osdl.org> <3F3986ED.1050206@pobox.com> <20030812173742.6e17f7d7.rddunlap@osdl.org> <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <20030813175009.GA12128@mars.ravnborg.org> <20030813175422.GZ10015@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20030813175422.GZ10015@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> +#define END_OF_LIST { 0, }


I prefer the shorter LIST_END or END_LIST.

	Jeff, always picking the tiniest of nits



