Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264873AbTLWAbt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 19:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264870AbTLWA36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 19:29:58 -0500
Received: from mail.kroah.org ([65.200.24.183]:36781 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264873AbTLWA32 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 19:29:28 -0500
Date: Mon, 22 Dec 2003 16:29:16 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: [PATCH] add sysfs misc device support  [3/4]
Message-ID: <20031223002916.GF4805@kroah.com>
References: <20031223002126.GA4805@kroah.com> <20031223002439.GB4805@kroah.com> <20031223002609.GC4805@kroah.com> <20031223002800.GD4805@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031223002800.GD4805@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 22, 2003 at 04:28:00PM -0800, Greg KH wrote:
> This adds /sys/class/mem which enables all misc char devices to show up
> properly in udev.

Oops, that should say, "/sys/class/misc".  Sorry for the typo.

greg k-h
