Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265647AbUFCQaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUFCQaH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 12:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbUFCQaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 12:30:06 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:7993 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265647AbUFCQaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 12:30:00 -0400
Date: Thu, 3 Jun 2004 09:28:49 -0700
From: Paul Jackson <pj@sgi.com>
To: Greg KH <greg@kroah.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de,
       rusty@rustcorp.com.au
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040603092849.60c73563.pj@sgi.com>
In-Reply-To: <20040603162402.GB3022@kroah.com>
References: <20040602161115.1340f698.pj@sgi.com>
	<20040602162330.0664ec5d.akpm@osdl.org>
	<20040602165902.73dfc977.pj@sgi.com>
	<20040602171724.2221f97e.akpm@osdl.org>
	<20040603162402.GB3022@kroah.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes, that is correct.

Good - thanks, Greg.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
