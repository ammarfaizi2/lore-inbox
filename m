Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVK3Qci@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVK3Qci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 11:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVK3Qci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 11:32:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13791 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751237AbVK3Qci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 11:32:38 -0500
Date: Wed, 30 Nov 2005 08:31:32 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
cc: akpm@osdl.org, Cliff Wickman <cpw@sgi.com>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] [PATCH 5/7] Direct Migration V5: remove_from_swap()
 to remove swap ptes
In-Reply-To: <438D8D22.4090303@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.62.0511300830470.19142@schroedinger.engr.sgi.com>
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
 <20051128204310.10037.32852.sendpatchset@schroedinger.engr.sgi.com>
 <438D8D22.4090303@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Nov 2005, KAMEZAWA Hiroyuki wrote:

> remove_from_swap(newpage) is sane ?

Yes, I will change that. Thank you for discovering the problem.

