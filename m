Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267451AbUHPGI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267451AbUHPGI2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHPGI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:08:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:41625 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267451AbUHPGI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:08:27 -0400
Date: Sun, 15 Aug 2004 23:08:27 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read cpumasks every time when exporting through sysfs
Message-Id: <20040815230827.241aa0d4.pj@sgi.com>
In-Reply-To: <1092619602.29608.47.camel@bach>
References: <1092619602.29608.47.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Read cpumasks every time when exporting through sysfs

Thanks, Rusty.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
