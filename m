Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbTEOSOP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTEOSOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:14:15 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:57756
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264145AbTEOSOP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:14:15 -0400
Date: Thu, 15 May 2003 14:27:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: walt <wa1ter@myrealbox.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: tg3 question for Jeff/Dave
Message-ID: <20030515182705.GA32134@gtf.org>
References: <3EC3DA43.8080404@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC3DA43.8080404@myrealbox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 11:19:47AM -0700, walt wrote:
> Once I do the down/up the Broadcom chip works well until the next reboot,
> when the same problem shows up again.  The Broadcom chip apparently is
> not fully initialized and winds up in some furshluginner state until
> another ifconfig down/up is done.

full lspci -v and full dmesg output would be useful initially

	Jeff



