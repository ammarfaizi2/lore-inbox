Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751999AbWFUGko@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbWFUGko (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 02:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbWFUGko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 02:40:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32673 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751999AbWFUGkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 02:40:43 -0400
Date: Tue, 20 Jun 2006 23:40:13 -0700
From: Paul Jackson <pj@sgi.com>
To: James Morris <jmorris@namei.org>
Cc: akpm@osdl.org, sds@tycho.nsa.gov, linux-kernel@vger.kernel.org,
       dpquigl@tycho.nsa.gov, mingo@elte.hu
Subject: Re: [PATCH 2/2] SELinux: Add security hook call to mediate
 attach_task (kernel/cpuset.c)
Message-Id: <20060620234013.2d3c07d7.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0606210029230.5379@d.namei>
References: <Pine.LNX.4.64.0606210016370.5379@d.namei>
	<Pine.LNX.4.64.0606210029230.5379@d.namei>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James wrote:
> This patch adds a security hook call to enable security modules to control 
> the ability to attach a task to a cpuset. 

Looks reasonable to me.  Thanks.

Acked-by: Paul Jackson <pj@sgi.com>

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
