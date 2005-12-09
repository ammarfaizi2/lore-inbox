Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932758AbVLIAKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932758AbVLIAKp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 19:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932762AbVLIAKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 19:10:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:24235 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932758AbVLIAKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 19:10:43 -0500
Date: Thu, 8 Dec 2005 16:10:20 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: steiner@sgi.com
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 1/3] Zone reclaim V3: main patch
In-Reply-To: <20051208234058.GA11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512081609400.31444@schroedinger.engr.sgi.com>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
 <20051208210850.GS11190@wotan.suse.de> <Pine.LNX.4.62.0512081320200.30786@schroedinger.engr.sgi.com>
 <20051208225102.GW11190@wotan.suse.de> <Pine.LNX.4.62.0512081514510.31246@schroedinger.engr.sgi.com>
 <20051208232827.GZ11190@wotan.suse.de> <Pine.LNX.4.62.0512081531150.31342@schroedinger.engr.sgi.com>
 <20051208234058.GA11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Dec 2005, Andi Kleen wrote:

> Unless non local same box is 2 times as slow as the local I wouldn't
> consider that correct.  (I would expect the Altix to do better than that) 

Maybe Jack could give us a hint how these slit numbers relate to 
reality?

