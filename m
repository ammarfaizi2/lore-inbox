Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbVDTC2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbVDTC2Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 22:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261299AbVDTC2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 22:28:25 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40166 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261288AbVDTC2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 22:28:23 -0400
Date: Tue, 19 Apr 2005 19:27:57 -0700
From: Paul Jackson <pj@sgi.com>
To: =?ISO-8859-1?B?SvZybg==?= Engel <joern@wohnheim.fh-wedel.de>
Cc: arnd@arndb.de, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ppc64: rename arch/ppc64/kernel/pSeries_pci.c
Message-Id: <20050419192757.28aa55e1.pj@sgi.com>
In-Reply-To: <20050420021245.GA7257@wohnheim.fh-wedel.de>
References: <200504200149.22063.arnd@arndb.de>
	<200504200152.58965.arnd@arndb.de>
	<20050420021245.GA7257@wohnheim.fh-wedel.de>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You might want to be consistent wrt. braces for one-line conditional
> statements.

Perhaps he is consistent - just not to any of the rules that you
considered.

For example, I will add braces even to a one-line conditional if due to
wrapping long lines, it really takes two or more screen lines for the
conditional.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
