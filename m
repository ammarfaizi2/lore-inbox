Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275318AbTHSDdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275319AbTHSDdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:33:23 -0400
Received: from 136.231.118.64.mia-ftl.netrox.net ([64.118.231.136]:48274 "EHLO
	smtp.netrox.net") by vger.kernel.org with ESMTP id S275318AbTHSDdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:33:22 -0400
Date: Mon, 18 Aug 2003 23:33:18 -0400
Subject: Re: [RFC] /sys/class/mem support
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Greg KH <greg@kroah.com>
From: Robert Love <rml@tech9.net>
In-Reply-To: <20030819003305.GA1546@kroah.com>
Message-Id: <E02A94CE-D1F5-11D7-8742-000A95686284@tech9.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday, August 18, 2003, at 08:33  PM, Greg KH wrote:

> Here's a patch against the latest 2.6.0-test3-bk tree that adds
> /sys/class/mem support for the "memory" char devices.  I know that
> Robert Love was thinking of moving some of the /proc/sys/kernel/random/
> files into sysfs, so this patch is needed for him to do this (Robert,
> you will need to export some variables for this to work, this patch is
> just a start...)

Cool.  Thanks, Greg.

Looks good to me.

	Robert Love

