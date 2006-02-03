Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422964AbWBCU7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422964AbWBCU7r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422953AbWBCU7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:59:46 -0500
Received: from main.gmane.org ([80.91.229.2]:35279 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422959AbWBCU7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:59:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alexander Fieroch <fieroch@web.de>
Subject: Re: [2.6.16rc2] compile error
Date: Fri, 03 Feb 2006 21:59:25 +0100
Message-ID: <ds0g7d$ug0$1@sea.gmane.org>
References: <ds08vk$hk$1@sea.gmane.org> <87d5i48dxg.fsf@sycorax.lbl.gov>	<ds0ce1$dma$1@sea.gmane.org> <87vevw6u0z.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: osten.wh.uni-dortmund.de
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: de-de, en-us, en
In-Reply-To: <87vevw6u0z.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Romosan wrote:
> you are probably running udev or something like that which generates
> the devices automagically...

yes I do. Next time '/etc/init.d/udev restart' should recreate /dev/null?

Regards,
Alexander

