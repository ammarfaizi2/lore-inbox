Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265517AbUFCRik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265517AbUFCRik (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFCRhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:37:18 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:65339 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264367AbUFCRep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:34:45 -0400
Date: Thu, 3 Jun 2004 10:34:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Stock IA64 kernel on SGI Altix 350
Message-Id: <20040603103438.24115ac2.pj@sgi.com>
In-Reply-To: <20040603170147.GK10708@fi.muni.cz>
References: <20040603170147.GK10708@fi.muni.cz>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am routinely building and booting *-mm kernels on Altix systems.  For
example, the 2.6.7-rc2-mm2 kernel I made from Andrews patch set of last
night works fine.  His patch set 2.6.7-rc2-mm1 had "issues", but
apparently not just on Altix.

I'd guess that Linus's kernels, such as 2.6.7-rc2, unpatched, are ok too,
but I don't have actual experience with them of late.

I don't know about the kernel/ports/ia64/v2.[46] patches.  I am not
adding any such for my work, at least not lately.

> Is there a better list to report this than lkml?

Probably - but I don't know where.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
