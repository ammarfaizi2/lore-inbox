Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVGYUHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVGYUHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVGYUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:04:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:6889 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261521AbVGYUCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:02:40 -0400
Subject: Re: kernel debugging
From: Lee Revell <rlrevell@joe-job.com>
To: uma@email.unc.edu
Cc: linux-kernel@vger.kernel.org, anderegg@cs.unc.edu
In-Reply-To: <20050725152348.6o1f03u9r4k8cgk0@webmail1.isis.unc.edu>
References: <42E3946E.4010009@cs.unc.edu>
	 <20050725152348.6o1f03u9r4k8cgk0@webmail1.isis.unc.edu>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 16:02:37 -0400
Message-Id: <1122321758.1472.29.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 15:23 -0400, uma@email.unc.edu wrote:
> I am using Red Hat sources, which has function open_kcore() hardcoded to
> return -EPERM always.
> 
> Changing this function to the way it is defined in the public sources (as
> shown below) did the trick.

All these Red Hat / RHEL threads are completely OT.  Please take it to a
Red Hat list.

Lee

