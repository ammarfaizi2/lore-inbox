Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVCRDIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVCRDIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVCRDIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:08:11 -0500
Received: from hera.kernel.org ([209.128.68.125]:60549 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261443AbVCRDIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:08:07 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: BKCVS broken ?
Date: Fri, 18 Mar 2005 03:07:50 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <d1dgm6$ma5$1@terminus.zytor.com>
References: <20050317144522.GK22936@hottah.alcove-fr> <20050317154434.GA24378@bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1111115270 22854 127.0.0.1 (18 Mar 2005 03:07:50 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 18 Mar 2005 03:07:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050317154434.GA24378@bitmover.com>
By author:    lm@bitmover.com (Larry McVoy)
In newsgroup: linux.dev.kernel
>
> I'll check into it.  We've been having problems with connecting to 
> master.kernel.org, yup, here you go, anyone else seeing this?
> 
> From lm@slovax.bitmover.com  Thu Mar 17 05:06:57 2005
> Date: Thu, 17 Mar 2005 05:00:57 -0800
> From: root@slovax.bitmover.com (Cron Daemon)
> To: lm@slovax.bitmover.com
> Subject: Cron <lm@slovax> /bk-cvsexport/src/UPDATE
> 
> Read from remote host master.kernel.org: Connection timed out
> 

Please Cc: any reports of badness on kernel.org to
ftpadmin@kernel.org; I would have seen this quicker that way.

Around the time the above happened the machine was pretty bogged down,
because we're preparing new hardware to replace the main server, and
were doing some very large copies.  It might have caused a timeout.

I notice a long login from you at approximately 14:00 PST; does that
mean this is no longer an issue?

	-hpa
