Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVDPIha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVDPIha (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 04:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVDPIha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 04:37:30 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57741 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S261422AbVDPIh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 04:37:26 -0400
Date: Sat, 16 Apr 2005 01:35:41 -0700
From: Paul Jackson <pj@sgi.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: torvalds@osdl.org, jgarzik@pobox.com, benh@kernel.crashing.org,
       linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.com,
       dwmw2@infradead.org
Subject: Re: New SCM and commit list
Message-Id: <20050416013541.2e6f6c60.pj@sgi.com>
In-Reply-To: <tnx64ys8gq1.fsf@arm.com>
References: <1113174621.9517.509.camel@gaston>
	<Pine.LNX.4.58.0504101621200.1267@ppc970.osdl.org>
	<425A10EA.7030607@pobox.com>
	<Pine.LNX.4.58.0504102304050.1267@ppc970.osdl.org>
	<tnx64ys8gq1.fsf@arm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "merge" does a better job than "diff3" since it can resolve the

The merge command I know of is part of Tichy's RCS tools,
and calls diff3, and has no inherent superior abilities.

Is this the merge command you have in mind here?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
