Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290722AbSBOTnF>; Fri, 15 Feb 2002 14:43:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290728AbSBOTmz>; Fri, 15 Feb 2002 14:42:55 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:61986 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290743AbSBOTmn>; Fri, 15 Feb 2002 14:42:43 -0500
Date: Fri, 15 Feb 2002 14:42:42 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200202151942.g1FJggl18232@devserv.devel.redhat.com>
To: jo-lkml@suckfuell.net, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sard patch for 2.4 - again
In-Reply-To: <mailman.1013771581.25586.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1013771581.25586.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I want to ask if the sard patch by Stephen Tweedie will be included into
> future 2.4 kernels. This patch collects hard disk statistics that are
> important figures on productive systems.
>[...]
> Correct me if I'm wrong, but the last release of the sard patch was for
> 2.4.0. In an src.rpm by Redhat I found a version of the patch that
> applied to 2.4.18-pre7 (but still labeled 2.4.0).

The filename does not matter. If it sits in an RPM, then it
is good for the version of base kernel that the RPM uses.
I know for the fact that Stephen updated it for cooperation
with add_gendisk/del_gendisk in 2.4.16, so the patch is
maintained actively. I would not worry about it, it's a good
patch.

-- Pete
