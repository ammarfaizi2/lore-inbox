Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTI2VNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 17:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263051AbTI2VNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 17:13:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17797 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263011AbTI2VLs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 17:11:48 -0400
Message-ID: <3F78A007.9090006@pobox.com>
Date: Mon, 29 Sep 2003 17:11:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ULL fixes for qlogicfc
References: <E1A41Rq-0000NJ-00@hardwired> <20030929172329.GD6526@gtf.org>	 <bla4fg$pbp$1@cesium.transmeta.com> <1064867628.5033.1.camel@laptop.fenrus.com>
In-Reply-To: <1064867628.5033.1.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> even dumbe question, why don't we provide ONE #define
> PCI_DMA_MASK_64BIT that does it right.... 
> and use that in all needed places
> (of course we need a _32BIT one too)

It's been suggested before, and I have no objection.

Wanna cook up the patch?  ;-)

	Jeff



