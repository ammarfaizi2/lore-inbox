Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbUCPGPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 01:15:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbUCPGPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 01:15:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44996 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263394AbUCPGPG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 01:15:06 -0500
Message-ID: <40569B4B.2020402@pobox.com>
Date: Tue, 16 Mar 2004 01:14:35 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       prism54-devel@prism54.org, netdev@oss.sgi.com, jgarzik@redhat.com
Subject: Re: Prism54 in 2.6.4-bk2
References: <5.1.0.14.2.20040313180709.00ab4250@pop.t-online.de> <1079199572.7111.0.camel@lapy.tuxslare.org> <20040313203058.GY32439@ruslug.rutgers.edu> <20040313221529.GC32439@ruslug.rutgers.edu>
In-Reply-To: <20040313221529.GC32439@ruslug.rutgers.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis R. Rodriguez wrote:
> Regarding WDS on prism54: on the netdev list we discussed this
> but no one got back to me as to whether we should really just nuke this
> code. Prism54 driver source *does* include WDS support because hey, the
> firmware does. Why wouldn't it go in the driver? We haven't given WDS
> much though anyway since it's also been low priority on our TODO list.

The WDS code was dead code as merged.

If you actually use it, I don't mind adding it :)

	Jeff



