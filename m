Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161317AbWASE7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161317AbWASE7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 23:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161318AbWASE7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 23:59:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:18925 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1161317AbWASE7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 23:59:21 -0500
Date: Wed, 18 Jan 2006 20:59:11 -0800
From: Paul Jackson <pj@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, mingo@elte.hu, ashok.raj@intel.com,
       mm-commits@vger.kernel.org
Subject: Re: + fix-cpucontrol-cache_chain_mutex-lock-inversion-bug.patch
 added to -mm tree
Message-Id: <20060118205911.da312c7b.pj@sgi.com>
In-Reply-To: <200601190241.k0J2fhKb015054@shell0.pdx.osdl.net>
References: <200601190241.k0J2fhKb015054@shell0.pdx.osdl.net>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> The interesting thing about this bug is that I found it via a new
> CONFIG_DEBUG_MUTEXES feature i'm working on ...

Nice work, Ingo.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
