Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264273AbTKKGD2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 01:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264274AbTKKGD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 01:03:28 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:35290 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S264273AbTKKGD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 01:03:26 -0500
Message-ID: <3FB07BA5.5010202@backtobasicsmgmt.com>
Date: Mon, 10 Nov 2003 23:03:17 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Success with  Promise FastTrak S150 TX4 (Re: [BK PATCHES] libata
 fixes)
References: <20031108172621.GA8041@gtf.org> <20031110095248.GA20497@magi.fakeroot.net> <3FAFBC28.5000600@pobox.com> <20031110172613.GA2962@magi.fakeroot.net> <3FAFDA5E.4050905@pobox.com>
In-Reply-To: <3FAFDA5E.4050905@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> Thank Promise, too.  They are actively supporting my efforts on this 
> driver with hardware and docs.  Promise has also provided Arjan (author 
> of "pdcraid") with documentation on their vendor-specific RAID format, 
> and they are making other efforts to better support open source, and be 
> more friendly with the open source community.

And it's working, I would not have purchased a SATA150 TX4 for my new 
server if libata did not have support for it. I know, it's small 
potatoes, they didn't make much money off that sale, but everything 
helps. The only other 4-port (non RAID) SATA card I have seen was from 
SIIG, but it has disappeared from their web site and distributors, and 
libata's support for the Sil3114 on it isn't ready yet anyway :-)

