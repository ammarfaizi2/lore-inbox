Return-Path: <linux-kernel-owner+w=401wt.eu-S1752581AbWLSFmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbWLSFmp (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 00:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbWLSFmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 00:42:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:42353 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752581AbWLSFmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 00:42:44 -0500
Date: Mon, 18 Dec 2006 21:41:59 -0800
From: Paul Jackson <pj@sgi.com>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: yanmin_zhang@linux.intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       jes@sgi.com, hch@lst.de, viro@zeniv.linux.org.uk, sgrubb@redhat.com,
       linux-audit@redhat.com, pj@sgi.com, systemtap@sources.redhat.com
Subject: Re: Task watchers v2
Message-Id: <20061218214159.2d571bf5.pj@sgi.com>
In-Reply-To: <1166447901.995.110.camel@localhost.localdomain>
References: <20061215000754.764718000@us.ibm.com>
	<20061215000817.771088000@us.ibm.com>
	<1166420641.15989.117.camel@ymzhang>
	<1166447901.995.110.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt wrote:
> - Task watchers can actually improve kernel performance slightly (up to
> 2% in extremely fork-heavy workloads for instance).

Nice.

Could you explain why?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
