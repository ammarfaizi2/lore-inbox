Return-Path: <linux-kernel-owner+w=401wt.eu-S932229AbXAPDvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbXAPDvP (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 22:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbXAPDvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 22:51:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38967 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932229AbXAPDvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 22:51:14 -0500
Date: Mon, 15 Jan 2007 19:51:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Bob Picco <bob.picco@hp.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPUSET related breakage of sys_mbind
In-Reply-To: <20070115184313.70ba25df.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0701151950200.15083@schroedinger.engr.sgi.com>
References: <20070115231050.GA32220@localhost> <20070115184313.70ba25df.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2007, Paul Jackson wrote:

> You're right about this problemI think that Christoph Lameter
> (added to cc list) is working on a fix for this.

Cpusets is your thing so I think you could fix this the right way. There 
are already two different patches fixing this. Just make it the way that 
it fits cpusets.


