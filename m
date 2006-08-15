Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbWHOSdt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWHOSdt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWHOSds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:33:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22156 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030450AbWHOSdr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:33:47 -0400
Date: Tue, 15 Aug 2006 11:33:43 -0700
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, containers@lists.osdl.org
Subject: Re: The rest of my proc cleanup.
Message-Id: <20060815113343.69529c02.pj@sgi.com>
In-Reply-To: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
References: <m1u04d98wa.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches seem ok to me:
 1) in their trivial impact on cpusets, and
 2) as a good cleanup.

Perhaps others wiser (more seniority in the school of
hard knocks) will see problems with them.  I don't.

Thanks.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
