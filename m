Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263302AbTJaMZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 07:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbTJaMZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 07:25:40 -0500
Received: from quechua.inka.de ([193.197.184.2]:4772 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S263302AbTJaMZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 07:25:40 -0500
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Post-halloween doc updates.
Date: Fri, 31 Oct 2003 13:25:08 +0100
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.31.12.25.07.551785@dungeon.inka.de>
References: <20031030141519.GA10700@redhat.com>
To: linux-kernel@vger.kernel.org, Dave Jones <davej@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Oct 2003 14:19:47 +0000, Dave Jones wrote:
> Deprecated/obsolete features.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - devfs has been obsoleted in favour of udev (http://www.kernel.org/pub/linux/utils/kernel/hotplug/)

s/has been obsoleted/will be olsoleted some day/

many devices need to be added to sysfs,
before udev+sysfs can replace devfs.


