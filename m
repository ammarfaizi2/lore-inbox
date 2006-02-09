Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbWBISYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbWBISYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWBISYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:24:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37268 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932533AbWBISYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:24:30 -0500
Date: Thu, 9 Feb 2006 10:24:03 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: marc@osknowledge.org, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation,
 removed unneeded return
Message-Id: <20060209102403.290be4d7.zaitcev@redhat.com>
In-Reply-To: <Pine.LNX.4.61.0602091823310.30108@yvahk01.tjqt.qr>
References: <mailman.1139418724.17734.linux-kernel2news@redhat.com>
	<20060208194057.55b02719.zaitcev@redhat.com>
	<Pine.LNX.4.61.0602091823310.30108@yvahk01.tjqt.qr>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2006 18:24:20 +0100 (MET), Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> Now what if
> 
> switch(a) {
> case A: {
>     int tmp;
>     do_something;
>     break;
> }
> }

Not in _my_ code.

-- Pete
