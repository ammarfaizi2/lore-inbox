Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965923AbWKNQ5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965923AbWKNQ5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 11:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966207AbWKNQ5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 11:57:52 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:22412 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965923AbWKNQ5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 11:57:51 -0500
Date: Tue, 14 Nov 2006 08:57:26 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
cc: kenneth.w.chen@intel.com, Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched domain: move sched group allocations to percpu
 area
In-Reply-To: <20061113170648.F17720@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0611140854370.11435@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0611122137190.2708@schroedinger.engr.sgi.com>
 <000201c706ee$a9992e80$a081030a@amr.corp.intel.com> <20061113170648.F17720@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, Siddha, Suresh B wrote:

> Christoph, Can you please test this on your big systems and ACK it? Thanks.

We also thought about fixing it this way. Thanks!

Acked-by: Christoph Lameter <clameter@sgi.com>

