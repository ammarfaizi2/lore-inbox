Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWHCSx1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWHCSx1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWHCSx1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:53:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:1960 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964799AbWHCSx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:53:26 -0400
Date: Thu, 3 Aug 2006 11:53:18 -0700
From: Paul Jackson <pj@sgi.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] percpu_alloc: correct function prototypes
Message-Id: <20060803115318.a7083be7.pj@sgi.com>
In-Reply-To: <1154631088.2963.9.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
References: <1154631088.2963.9.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> This patch corrects a couple of inconsistencies regarding percpu_*()

Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
