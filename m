Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267330AbUI0UOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267330AbUI0UOE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 16:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUI0ULl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 16:11:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38080 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267330AbUI0UL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 16:11:26 -0400
Date: Mon, 27 Sep 2004 13:10:14 -0700
From: Paul Jackson <pj@sgi.com>
To: Roland Dreier <roland@topspin.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Message-Id: <20040927131014.695b8212.pj@sgi.com>
In-Reply-To: <10963027102899@topspin.com>
References: <1096302710971@topspin.com>
	<10963027102899@topspin.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland wrote:
> Add a HOTPLUG_ENV_VAR macro ...

Would a procedure (not inlined) save text space here,
provide better type checking, and be easier to read?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
