Return-Path: <linux-kernel-owner+w=401wt.eu-S964926AbWLMSsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWLMSsg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbWLMSsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:48:36 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:37999 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964926AbWLMSsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:48:35 -0500
X-Greylist: delayed 987 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 13:48:35 EST
Date: Wed, 13 Dec 2006 10:31:29 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_VM_EVENT_COUNTER comment decrustify
In-Reply-To: <20061213181956.6440.15235.sendpatchset@jackhammer.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0612131031120.19913@schroedinger.engr.sgi.com>
References: <20061213181956.6440.15235.sendpatchset@jackhammer.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006, Paul Jackson wrote:

> From: Paul Jackson <pj@sgi.com>
> 
> The VM event counters, enabled by CONFIG_VM_EVENT_COUNTERS,
> which provides VM event counters in /proc/vmstat, has become
> more essential to non-EMBEDDED kernel configurations than they
> were in the past.  Comments in the code and the Kconfig configuration
> explanation were stale, downplaying their role excessively.
> 
> Refresh those comments to correctly reflect the current role of
> VM event counters.
> 
> Signed-off-by: Paul Jackson <pj@sgi.com>

Acked-by: Christoph Lameter <clameter@sgi.com>
