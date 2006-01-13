Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422837AbWAMTRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422837AbWAMTRT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbWAMTRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:17:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27339 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1422837AbWAMTRS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:17:18 -0500
Date: Fri, 13 Jan 2006 11:17:15 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: yhlu <yhlu.kernel@gmail.com>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can not compile in the latest git
In-Reply-To: <86802c440601130930k5abfda2m91294c43641283@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0601131112510.6233@schroedinger.engr.sgi.com>
References: <86802c440601111021m7cb40881m7206d9342534f844@mail.gmail.com> 
 <Pine.LNX.4.62.0601111213270.24355@schroedinger.engr.sgi.com> 
 <86802c440601121236s47d5737fo45105ce3ebc746a6@mail.gmail.com> 
 <Pine.LNX.4.62.0601121958570.2740@schroedinger.engr.sgi.com>
 <86802c440601130930k5abfda2m91294c43641283@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, yhlu wrote:

> So the CONFIG_MIGRATION depends on CONFIG_NUMA and CONFIG_SWAP?

Yes. Maybe this will change in the future if we can find another way to 
preserve the anonymous mappings.

