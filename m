Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759027AbWK3EtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759027AbWK3EtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 23:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759030AbWK3EtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 23:49:05 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19622 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1759027AbWK3EtE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 23:49:04 -0500
Date: Wed, 29 Nov 2006 20:48:51 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: felix@obenhuber.de, linux-kernel@vger.kernel.org,
       dynsched-devel@lists.sourceforge.net, menage@google.com
Subject: Re: [RFC] dynsched - different cpu schedulers per cpuset
Message-Id: <20061129204851.ecc7dbb0.pj@sgi.com>
In-Reply-To: <20061129201310.54da1618.pj@sgi.com>
References: <1164557189.10306.12.camel@athrose>
	<20061129201310.54da1618.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pj wrote:
> See Paul Menage's most recent patch proposal at:
>   http://lkml.org/lkml/2006/11/17/217
>   Subject: [PATCH 0/6] Multi-hierarchy Process Containers
>   Date:    Fri, 17 Nov 2006 11:11:59 -0800

I'm behind the times.  Paul Menage's most recent proposal is at:
    http://lkml.org/lkml/2006/11/23/95
    Subject: [PATCH 0/7] Generic Process Containers (+ ResGroups/BeanCounters)
    Date:    Thu, 23 Nov 2006 04:08:48 -0800

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
