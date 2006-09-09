Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbWIICNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbWIICNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 22:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIICNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 22:13:13 -0400
Received: from ihug-mail.icp-qv1-irony5.iinet.net.au ([203.59.1.199]:56098
	"EHLO mail-ihug.icp-qv1-irony5.iinet.net.au") by vger.kernel.org
	with ESMTP id S1750863AbWIICNM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 22:13:12 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.09,135,1157299200"; 
   d="scan'208"; a="911763342:sNHT27018458"
Message-ID: <45022333.6030605@eyal.emu.id.au>
Date: Sat, 09 Sep 2006 12:13:07 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20060830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17.12
References: <20060908220741.GA26950@kroah.com>
In-Reply-To: <20060908220741.GA26950@kroah.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> We (the -stable team) are announcing the release of the 2.6.17.12 kernel.

A quick report, will investigate later:

WARNING: /lib/modules/2.6.17.12/kernel/drivers/md/dm-mod.ko needs unknown symbol idr_replace

I did not change my config throughout the series.

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
