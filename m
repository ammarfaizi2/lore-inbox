Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUBXPec (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 10:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUBXPec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 10:34:32 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:62137 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262279AbUBXPe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 10:34:29 -0500
Subject: Re: [BK PATCH] SCSI update for 2.6.3
From: James Bottomley <James.Bottomley@steeleye.com>
To: joe.korty@ccur.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040224152451.GA21699@tsunami.ccur.com>
References: <1077596668.1983.282.camel@mulgrave> 
	<20040224152451.GA21699@tsunami.ccur.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 24 Feb 2004 09:34:25 -0600
Message-Id: <1077636866.2152.55.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-02-24 at 09:24, Joe Korty wrote:
>  I am getting a panic out of the 2.6.3 Fusion driver when no devices
> are attached to it.  Does the above update fix it?  If so, I would
> like to get a copy of the above in patch form.  If not, I can send
> you a copy of my boot log.

Well, without a bug report I don't really have any idea.

The patch is here:

http://marc.theaimsgroup.com/?l=linux-scsi&m=107670916906716&w=2

James


