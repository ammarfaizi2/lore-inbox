Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262393AbUKKWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbUKKWkW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 17:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbUKKWhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 17:37:09 -0500
Received: from main.gmane.org ([80.91.229.2]:60291 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262401AbUKKWeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 17:34:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: network interface to driver and pci slot mapping
Date: Thu, 11 Nov 2004 23:34:41 +0100
Message-ID: <yw1xhdnwnhfi.fsf@ford.inprovide.com>
References: <8874763604111113281b1cf9a5@mail.gmail.com> <Pine.LNX.4.61.0411111640470.11012@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 76.80-203-227.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:1JtVyGJsC3DhdWnqAd8QwLph3z0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os <linux-os@chaos.analogic.com> writes:

> If the eth0 device is a module, it's in /etc/modprobe.conf, previous
> versions used /etc/modules.conf.
> Once you have its module name you can use other resources like
>
> /sys/bus/pci/drivers/MODULENAME

On my systems, hotplug loads the modules automatically, so there is
no mention of them anywhere.

-- 
Måns Rullgård
mru@inprovide.com

