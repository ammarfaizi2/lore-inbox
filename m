Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264900AbTFTVmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTFTVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:42:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10419 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264893AbTFTVlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:41:37 -0400
Message-ID: <3EF382CF.2020800@pobox.com>
Date: Fri, 20 Jun 2003 17:55:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       David Lang <david.lang@digitalinsight.com>, jmorris@intercode.com.au,
       davem@redhat.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
References: <20030620194517.GA22732@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0306201247560.28021-100000@dlang.diginsite.com> <20030620200554.GC22732@wohnheim.fh-wedel.de> <3EF38248.2070807@pobox.com>
In-Reply-To: <3EF38248.2070807@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> If you drop that down to 280k with much better compression than zlib, 
> that's fantastic and useful, and people won't mind the slower algorithm :)

Just so people don't misinterpret this, I'm just talking about the 
_addition_ of bzlib as an option.  zlib isn't going anywhere.

	Jeff



