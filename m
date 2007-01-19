Return-Path: <linux-kernel-owner+w=401wt.eu-S1751561AbXASEHc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbXASEHc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 23:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751589AbXASEHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 23:07:32 -0500
Received: from gw.goop.org ([64.81.55.164]:55397 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553AbXASEHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 23:07:31 -0500
Message-ID: <45B043FA.9090905@goop.org>
Date: Fri, 19 Jan 2007 15:07:22 +1100
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 17/20] XEN-paravirt: Add Xen grant table support
References: <20070113014539.408244126@goop.org> <20070113014648.925356430@goop.org> <20070115130556.GB4272@ucw.cz>
In-Reply-To: <20070115130556.GB4272@ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> What is going on? Diffstat does not seem to match the diff.
Sorry, forgot to update the diffstat for this one:

 drivers/xen/Makefile           |    1 
 drivers/xen/core/Makefile      |    1 
 drivers/xen/core/grant_table.c |  445 ++++++++++++++++++++++++++++++++++++++++
 include/xen/grant_table.h      |  107 +++++++++
 4 files changed, 554 insertions(+)


    J
