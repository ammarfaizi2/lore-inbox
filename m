Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030498AbWBNGo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030498AbWBNGo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 01:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWBNGo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 01:44:57 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:51411 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1030498AbWBNGo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 01:44:56 -0500
Date: Tue, 14 Feb 2006 15:44:39 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: "Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, balbir.singh@in.ibm.com
Subject: Re: [ckrm-tech] [PATCH 1/2] add a CPU resource controller
In-Reply-To: <88299102B8C1F54BB5C8E47F30B2FBE201E95E78@inblr-exch1.eu.uis.unisys.com>
References: <88299102B8C1F54BB5C8E47F30B2FBE201E95E78@inblr-exch1.eu.uis.unisys.com>
X-Mailer: Sylpheed version 2.2.0beta8 (GTK+ 2.8.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20060214064440.1398D7402D@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006 11:36:56 +0530
"Suryanarayanan, Rajaram" <Rajaram.Suryanarayanan@in.unisys.com> wrote:

> I have downloaded the CPU resource controller for 2.6.14 ( f-series
> cpurc_v0.3-2614 ). So is your resource controller built on top of this ?

The patch that I had sent is the forward port of cpurc_v0.3-2614.

> Has the logic of CPU resource controller been changed in 2.6.15 than
> what I have with me for 2.6.14 ?

No, the resource control logic is the same as cpurc_v0.3-2614.

-- 
KUROSAWA, Takahiro
